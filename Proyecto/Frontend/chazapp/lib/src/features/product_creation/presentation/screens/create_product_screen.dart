import 'dart:io';

import 'package:chazapp/src/config/themes/unchaza_theme.dart';
import 'package:chazapp/src/features/auth/presentation/bloc/login/login_bloc.dart';
import 'package:chazapp/src/features/auth/presentation/bloc/login/login_event.dart';
import 'package:chazapp/src/features/auth/presentation/bloc/login/login_state.dart';
import 'package:chazapp/src/features/home/presentation/widgets/custom_button.dart';
import 'package:chazapp/src/features/product_creation/domain/entities/category_entity.dart';
import 'package:chazapp/src/features/product_creation/presentation/bloc/category/category_bloc.dart';
import 'package:chazapp/src/features/product_creation/presentation/bloc/category/category_event.dart';
import 'package:chazapp/src/features/product_creation/presentation/bloc/products/products_event.dart';
import 'package:chazapp/src/features/product_creation/presentation/bloc/products/products_state.dart';
import 'package:chazapp/src/features/profile/domain/enitites/chaza_entity.dart';
import 'package:go_router/go_router.dart';
import 'package:chazapp/src/features/product_creation/presentation/bloc/category/category_state.dart';
import 'package:chazapp/src/features/product_creation/presentation/bloc/products/products_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CreateProductScreen extends StatefulWidget {
  final ChazaEntity chaza;

  const CreateProductScreen({super.key, required this.chaza});

  @override
  State<CreateProductScreen> createState() => _CreateProductScreenState();
}

class _CreateProductScreenState extends State<CreateProductScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _barcodeController = TextEditingController();
  final TextEditingController _anotherCategoryController =
      TextEditingController();
  final TextEditingController _anotherCategoryDescriptionController =
      TextEditingController();
  final ImagePicker _picker = ImagePicker();

  //List<CategoryEntity> categories = [];

  List<CategoryEntity> categories = [
    const CategoryEntity(
        id: "1", name: "Bebidas", description: "Refrescos y jugos"),
    const CategoryEntity(
        id: "2", name: "Snacks", description: "Aperitivos y bocadillos"),
    const CategoryEntity(
        id: "3", name: "Postres", description: "Dulces y repostería"),
    const CategoryEntity(
        id: "4",
        name: "Comida rápida",
        description: "Hamburguesas, pizzas, etc."),
    const CategoryEntity(
        id: "5", name: "Otra", description: "Categoría personalizada"),
  ];

  CategoryEntity anotherCategory = const CategoryEntity(
      id: "5", name: "Otra", description: "Categoría personalizada");

  CategoryEntity? selectedCategory;
  bool isAnotherCategory = false;
  XFile? _image;

  @override
  void initState() {
    super.initState();
    final token = context.read<LoginBloc>().state is LoginSuccess
        ? (context.read<LoginBloc>().state as LoginSuccess).userEntity.token
        : null;

    if (token == null) {
      context.read<LoginBloc>().add(CheckAuthStatus());
      return;
    }
    context.read<CategoryBloc>().add(GetCategoriesEvent(token));
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

      if (isAnotherCategory) {
        final name = _anotherCategoryController.text;
        final description = _anotherCategoryDescriptionController.text;
        context
            .read<CategoryBloc>()
            .add(CreateCategoryEvent(token, name, description));
        return;
      }
      final name = _nameController.text;
      final description = _descriptionController.text;
      final price = double.tryParse(_priceController.text) ?? 0.0;
      final category = selectedCategory!;

      _createProduct(
          name, price, description, widget.chaza.id, category.id, token);
    }
  }

  void _createProduct(name, price, description, chazaId, categoryId, token) {
    context.read<ProductsBloc>().add(
          ProductCreationRequested(
              name: name,
              price: price,
              description: description,
              chazaId: chazaId,
              categoryId: categoryId,
              token: token),
        );
  }

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
        title: Text("Crear Producto",
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
                  _buildTextField(_nameController, "ej: Empanada"),
                  _buildLabel("Categoria"),
                  BlocBuilder<CategoryBloc, CategoryState>(
                      builder: (context, state) {
                    if (state is CategoryLoadingState) {
                      return const CircularProgressIndicator();
                    } else if (state is CategoryLoadedState) {
                      categories = state.categories;
                      return DropdownButtonFormField<CategoryEntity>(
                        value: selectedCategory,
                        decoration: InputDecoration(
                          hintStyle: UNChazaTheme.textTheme.bodyLarge
                              ?.copyWith(color: UNChazaTheme.deepGrey),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: const BorderSide(
                                color: UNChazaTheme.deepGrey, width: 2.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: const BorderSide(
                                color: UNChazaTheme.orange, width: 2.0),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: const BorderSide(
                                color: UNChazaTheme.red, width: 2.0),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: const BorderSide(
                                color: UNChazaTheme.red, width: 2.0),
                          ),
                          errorStyle: UNChazaTheme.textTheme.bodySmall
                              ?.copyWith(color: UNChazaTheme.red),
                          filled: true,
                          fillColor: UNChazaTheme.white,
                          hintText: "Seleccione una categoría",
                        ),
                        items: categories.map((CategoryEntity category) {
                          return DropdownMenuItem<CategoryEntity>(
                            value: category,
                            child: Text(category.name),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedCategory = value;
                            isAnotherCategory = value?.name == "Otra";
                          });
                        },
                        validator: (value) =>
                            value == null ? "Seleccione una categoría" : null,
                      );
                    } else if (state is CategoryErrorState) {
                      return Text(state.dioException.message ?? "Error");
                    }
                    return const Text("Error");
                  }),
                  if (isAnotherCategory) ...[
                    _buildLabel("Nombre de la nueva categoría"),
                    _buildTextField(
                        _anotherCategoryController, "Ej: Comida saludable"),
                    _buildLabel("Descripción de la nueva categoría"),
                    _buildTextField(_anotherCategoryDescriptionController,
                        "Ej: Productos saludables y orgánicos",
                        maxLines: 3),
                  ],
                  const SizedBox(height: 20),
                  _buildLabel("Precio"),
                  _buildTextField(_priceController, "ej 5.000"),
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
                  _buildLabel("Código de Barras"),
                  _buildTextField(_barcodeController, "123456789"),
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
                      //TODO: Implementar el bloc
                      BlocConsumer<ProductsBloc, ProductsState>(
                        listener: (context, state) {
                          if (state is ProductsSuccess) {
                            context.go("/profile");
                          } else if (state is ProductsFailure) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content:
                                    Text(state.dioException.message ?? "Error"),
                                backgroundColor: UNChazaTheme.red,
                              ),
                            );
                          }
                        },
                        builder: (context, state) {
                          if (state is ProductsLoading) {
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
                        },
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
