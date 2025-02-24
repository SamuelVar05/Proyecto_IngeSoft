import 'package:chazapp/injection_container.dart';
import 'package:chazapp/src/config/themes/unchaza_theme.dart';
import 'package:chazapp/src/features/auth/presentation/bloc/login/login_bloc.dart';
import 'package:chazapp/src/features/auth/presentation/bloc/login/login_event.dart';
import 'package:chazapp/src/features/auth/presentation/bloc/login/login_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:chazapp/src/features/auth/presentation/widgets/custom_text_field.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: _formKey,
      child: Scaffold(
        backgroundColor: UNChazaTheme.orange,
        body: BlocProvider(
          create: (context) => sl<LoginBloc>(),
          child: BlocListener<LoginBloc, LoginState>(
            listener: (context, state) {
              if (state is LoginSuccess) {
                context.go('/home');
              }
            },
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          mainAxisSize:
                              MainAxisSize.min, // Importante para centrado
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/unchaza_logo.png',
                              height: 110,
                            ),
                            const SizedBox(height: 20),
                            Container(
                              decoration: BoxDecoration(
                                color: UNChazaTheme.mainGrey,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                children: [
                                  Text(
                                    "Iniciar Sesión",
                                    style: UNChazaTheme.textTheme.displayMedium,
                                  ),
                                  const SizedBox(height: 20),
                                  CustomTextField(
                                    name: "email",
                                    text: "Correo electrónico",
                                    hint: "ej: juan1234@gmail.com",
                                    keyboardType: TextInputType.text,
                                    validator: FormBuilderValidators.compose([
                                      FormBuilderValidators.required(
                                          errorText: "Correo requerido"),
                                      FormBuilderValidators.email(
                                          errorText: "Correo inválido"),
                                    ]),
                                  ),
                                  CustomTextField(
                                    name: "password",
                                    text: "Contraseña",
                                    hint: "********",
                                    isPassword: true,
                                    keyboardType: TextInputType.text,
                                    validator: FormBuilderValidators.compose([
                                      FormBuilderValidators.required(
                                          errorText: "Contraseña requerida"),
                                      FormBuilderValidators.password(
                                          errorText:
                                              "La contraseña debe tener al menos 8\ncaracteres, una letra mayúscula,un número\ny un caracter especial."),
                                    ]),
                                  ),
                                  const SizedBox(height: 8),
                                  BlocBuilder<LoginBloc, LoginState>(
                                    builder: (context, state) {
                                      if (state is LoginFailure) {
                                        return Text(
                                          //TODO: Cambiar el estilo del texto
                                          state.exception.message ??
                                              "Ocurrió un error inesperado. Vuelva a intentarlo.",
                                          style:
                                              UNChazaTheme.textTheme.labelSmall,
                                        );
                                      }
                                      return const SizedBox
                                          .shrink(); // Retorna un widget vacío si no hay error
                                    },
                                  ),
                                  const SizedBox(height: 8),
                                  ElevatedButton(
                                    onPressed: () {
                                      if (_formKey.currentState
                                              ?.saveAndValidate() ??
                                          false) {
                                        final formValues =
                                            _formKey.currentState!.value;
                                        final email = formValues['email'];
                                        final password = formValues['password'];

                                        context.read<LoginBloc>().add(
                                            LoginRequested(email, password));
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      foregroundColor: UNChazaTheme.black,
                                      backgroundColor: UNChazaTheme.yellow,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      padding: const EdgeInsets.only(
                                          right: 15,
                                          left: 15,
                                          top: 10,
                                          bottom: 10),
                                    ),
                                    child: Text(
                                      "Ingresar",
                                      style:
                                          UNChazaTheme.textTheme.headlineSmall,
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text("¿No tiene una cuenta?",
                                          style: UNChazaTheme
                                              .textTheme.labelSmall),
                                      const SizedBox(width: 5),
                                      ElevatedButton(
                                        onPressed: () {
                                          context.go('/signup');
                                        },
                                        style: ElevatedButton.styleFrom(
                                          foregroundColor: UNChazaTheme.black,
                                          backgroundColor:
                                              UNChazaTheme.mainGrey,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            side: const BorderSide(
                                                color: UNChazaTheme.black,
                                                width: 1.5),
                                          ),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8),
                                        ),
                                        child: Text("Registrarse",
                                            style: UNChazaTheme
                                                .textTheme.titleLarge),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
