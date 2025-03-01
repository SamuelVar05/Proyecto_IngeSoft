import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chazapp/src/features/auth/presentation/bloc/login/login_bloc.dart';
import 'package:chazapp/src/features/auth/presentation/bloc/login/login_state.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final token = context.select<LoginBloc, String>((bloc) {
      final state = bloc.state;
      if (state is LoginSuccess) {
        return state.userEntity.token;
      }
      throw Exception('No se pudo obtener el token');
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
      ),
      body: Center(
        child: Column(
          children: [
            const Text('Home Screen'),
            const Text('Bienvenido a la aplicación'),
            Text("Token: $token"),
            ElevatedButton(
              onPressed: () {
                context.go("/profile");
              },
              child: const Text("Perfil"),
            )
          ],
        ),
      ),
    );
  }
}
