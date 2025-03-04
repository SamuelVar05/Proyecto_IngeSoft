import 'dart:io';
import 'package:chazapp/src/config/themes/unchaza_theme.dart';
import 'package:chazapp/src/features/auth/presentation/bloc/login/login_bloc.dart';
import 'package:chazapp/src/features/auth/presentation/bloc/login/login_event.dart';
import 'package:chazapp/src/features/auth/presentation/bloc/login/login_state.dart';
import 'package:chazapp/src/features/chaza_creation/presentation/bloc/chaza_creation/chaza_creation_bloc.dart';
import 'package:chazapp/src/features/chaza_creation/presentation/bloc/chaza_creation/chaza_creation_event.dart';
import 'package:chazapp/src/features/chaza_creation/presentation/bloc/chaza_creation/chaza_creation_state.dart';
import 'package:chazapp/src/features/home/presentation/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateChazaScreen extends StatefulWidget {
  const CreateChazaScreen({super.key});

  @override
  _CreateChazaScreenState createState() => _CreateChazaScreenState();
}

class _CreateChazaScreenState extends State<CreateChazaScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _scheduleController = TextEditingController();
  XFile? _image;
  final ImagePicker _picker = ImagePicker();
  final List<String> _selectedPayments = [];

  Future<void> _pickImage() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = pickedFile;
      });
    }
  }

  void _removeImage() {
    setState(() {
      _image = null;
    });
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final loginBloc = context.read<LoginBloc>();
      if (loginBloc.state is LoginFailure || loginBloc.state is NoToken) {
        context.go("/login");
        return;
      }
      if (loginBloc.state is! LoginSuccess) {
        loginBloc.add(CheckAuthStatus());
        return;
      }

      final token = context.read<LoginBloc>().state is LoginSuccess
          ? (context.read<LoginBloc>().state as LoginSuccess).userEntity.token
          : null;

      if (token == null) {
        context.read<LoginBloc>().add(CheckAuthStatus());
        return;
      }

      context.read<ChazaCreationBloc>().add(
            ChazaCreationRequested(
              nombre: _nameController.text,
              descripcion: _descriptionController.text,
              ubicacion: _locationController.text,
              token: token,
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UNChazaTheme.white,
      appBar: AppBar(
        scrolledUnderElevation: 0.0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: UNChazaTheme.orange),
          onPressed: () => context.go("/profile"),
        ),
        title: Text("Crear Chaza",
            style: UNChazaTheme.textTheme.displayLarge
                ?.copyWith(color: UNChazaTheme.orange)),
        backgroundColor: UNChazaTheme.white,
        centerTitle: false,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: ConstrainedBox(
              constraints:
                  const BoxConstraints(maxWidth: 400), // Limita el ancho
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildLabel("Nombre"),
                  _buildTextField(_nameController, "ej: Chaza de Juanito"),
                  _buildLabel("Ubicación"),
                  _buildTextField(_locationController,
                      "ej: Nuevos Espacios para las Artes"),
                  _buildLabel("Descripción"),
                  _buildTextField(
                      _descriptionController, "Escribe una breve descripción",
                      maxLines: 5),
                  _buildLabel("Foto"),
                  CustomButton(
                    text: "Adjuntar foto",
                    buttonColor: UNChazaTheme.orange,
                    textColor: UNChazaTheme.white,
                    onPressed: _pickImage,
                    icon: Icons.image,
                  ),
                  const SizedBox(height: 10),
                  if (_image != null)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.file(
                            File(_image!.path),
                            width: 150,
                            height: 150,
                            fit: BoxFit.cover,
                          ),
                        ),
                        IconButton(
                          icon:
                              const Icon(Icons.delete, color: UNChazaTheme.red),
                          onPressed: _removeImage,
                        ),
                      ],
                    ),
                  _buildLabel("Medios de pago"),
                  Wrap(
                    spacing: 5,
                    children: [
                      "Efectivo",
                      "Nequi",
                      "Daviplata",
                      "Tarjeta débito/crédito",
                      "Transferencia bancaria"
                    ].map((payment) {
                      return Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Checkbox(
                            value: _selectedPayments.contains(payment),
                            onChanged: (bool? selected) {
                              setState(() {
                                if (selected == true) {
                                  _selectedPayments.add(payment);
                                } else {
                                  _selectedPayments.remove(payment);
                                }
                              });
                            },
                            activeColor: UNChazaTheme.orange,
                          ),
                          Text(payment,
                              style: UNChazaTheme.textTheme.bodyLarge),
                        ],
                      );
                    }).toList(),
                  ),
                  _buildLabel("Horario"),
                  _buildTextField(_scheduleController, "L-V HH:MM-HH:MM"),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CustomButton(
                        text: "Cancelar",
                        buttonColor: UNChazaTheme.deepGrey,
                        textColor: UNChazaTheme.white,
                        onPressed: () => Navigator.pop(context),
                        textStyle: UNChazaTheme.textTheme.headlineMedium
                            ?.copyWith(color: UNChazaTheme.white),
                      ),
                      BlocConsumer<ChazaCreationBloc, ChazaCreationState>(
                          listener: (context, state) {
                        if (state is ChazaCreationSuccess) {
                          context.go("/profile");
                        } else if (state is ChazaCreationFailure) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content:
                                  Text(state.dioException.message ?? "Error"),
                              backgroundColor: UNChazaTheme.red,
                            ),
                          );
                        }
                      }, builder: (context, state) {
                        if (state is ChazaCreationLoading) {
                          return const CircularProgressIndicator();
                        }
                        return CustomButton(
                          text: "Guardar",
                          buttonColor: UNChazaTheme.orange,
                          textColor: UNChazaTheme.white,
                          onPressed: _submitForm,
                          textStyle: UNChazaTheme.textTheme.headlineMedium
                              ?.copyWith(color: UNChazaTheme.white),
                        );
                      }),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 5),
      child: Text(text, style: UNChazaTheme.textTheme.headlineMedium),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hintText,
      {int maxLines = 1}) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        hintStyle: UNChazaTheme.textTheme.bodyLarge
            ?.copyWith(color: UNChazaTheme.deepGrey),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide:
              const BorderSide(color: UNChazaTheme.deepGrey, width: 2.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: UNChazaTheme.orange, width: 2.0),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: UNChazaTheme.red, width: 2.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: UNChazaTheme.red, width: 2.0),
        ),
        errorStyle:
            UNChazaTheme.textTheme.bodySmall?.copyWith(color: UNChazaTheme.red),
        filled: true,
        fillColor: UNChazaTheme.white,
        hintText: hintText,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Este campo es obligatorio";
        }
        return null;
      },
    );
  }
}
