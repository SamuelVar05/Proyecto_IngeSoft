import 'dart:io';
import 'package:chazapp/src/config/themes/unchaza_theme.dart';
import 'package:chazapp/src/features/home/presentation/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

class EditChazaScreen extends StatefulWidget {
  final String name;
  final String description;
  final String location;
  final String schedule;
  final String imageUrl;
  final List<String> payments;

  const EditChazaScreen(
      {super.key,
      required this.name,
      required this.description,
      required this.location,
      required this.schedule,
      required this.imageUrl,
      required this.payments});

  @override
  _EditChazaScreenState createState() => _EditChazaScreenState();
}

class _EditChazaScreenState extends State<EditChazaScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _scheduleController = TextEditingController();
  XFile? _image;
  final ImagePicker _picker = ImagePicker();
  List<String> _selectedPayments = [];

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
      // TODO: Enviar datos al backend
      print("Formulario válido. Enviar datos...");
    }
  }

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.name;
    _descriptionController.text = widget.description;
    _locationController.text = widget.location;
    _scheduleController.text = widget.schedule;
    _selectedPayments = List.from(widget.payments);
    //_image = widget.imageUrl.isNotEmpty ? XFile(widget.imageUrl) : null; //TODO: Cambiar por la imagen del backend
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UNChazaTheme.white,
      appBar: AppBar(
        scrolledUnderElevation: 0.0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: UNChazaTheme.orange),
          onPressed: () => context.go('/profile'),
        ),
        title: Text("Editar Chaza",
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
                        onPressed: () => context.go('/profile'),
                        textStyle: UNChazaTheme.textTheme.headlineMedium
                            ?.copyWith(color: UNChazaTheme.white),
                      ),
                      CustomButton(
                        text: "Guardar",
                        buttonColor: UNChazaTheme.orange,
                        textColor: UNChazaTheme.white,
                        onPressed: () {
                          _submitForm;
                          context.go('/profile');
                        },
                        textStyle: UNChazaTheme.textTheme.headlineMedium
                            ?.copyWith(color: UNChazaTheme.white),
                      ),
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
