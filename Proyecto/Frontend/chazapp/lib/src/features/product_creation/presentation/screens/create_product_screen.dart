import 'package:chazapp/src/features/auth/presentation/bloc/login/login_bloc.dart';
import 'package:chazapp/src/features/auth/presentation/bloc/login/login_event.dart';
import 'package:chazapp/src/features/auth/presentation/bloc/login/login_state.dart';
import 'package:chazapp/src/features/product_creation/domain/entities/category_entity.dart';
import 'package:chazapp/src/features/product_creation/presentation/bloc/category/category_bloc.dart';
import 'package:chazapp/src/features/product_creation/presentation/bloc/category/category_event.dart';
import 'package:chazapp/src/features/product_creation/presentation/bloc/products/products_event.dart';
import 'package:chazapp/src/features/profile/domain/enitites/chaza_entity.dart';
import 'package:go_router/go_router.dart';
import 'package:chazapp/src/features/product_creation/presentation/bloc/category/category_state.dart';
import 'package:chazapp/src/features/product_creation/presentation/bloc/products/products_bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  final TextEditingController _anotherCategoryController =
      TextEditingController();
  final TextEditingController _anotherCategoryDescriptionController =
      TextEditingController();
  final ImagePicker _picker = ImagePicker();

  List<CategoryEntity> categories = [];
  CategoryEntity? categoriaSeleccionada;
  bool isAnotherCategory = false;
  XFile? image;

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
      final price = _priceController.text as double;
      final category = categoriaSeleccionada!;

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

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CategoryBloc, CategoryState>(
      listener: (context, state) {
        if (state is CategoryCreatedState) {
          final loginState = context.read<LoginBloc>().state;
          if (loginState is LoginSuccess) {
            _createProduct(
              _nameController.text,
              double.tryParse(_priceController.text) ?? 0.0,
              _descriptionController.text,
              widget.chaza.id,
              state.category.id,
              loginState.userEntity.token, // Obtener el token aquí
            );
          } else {
            context.read<LoginBloc>().add(CheckAuthStatus());
          }
        }
      },
      builder: (context, state) {
        return Container();
      },
    );
  }
}
