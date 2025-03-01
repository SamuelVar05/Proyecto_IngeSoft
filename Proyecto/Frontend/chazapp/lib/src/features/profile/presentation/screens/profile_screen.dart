import 'package:chazapp/injection_container.dart';
import 'package:go_router/go_router.dart';
import 'package:chazapp/src/features/auth/presentation/bloc/login/login_bloc.dart';
import 'package:chazapp/src/features/auth/presentation/bloc/login/login_event.dart';
import 'package:chazapp/src/features/auth/presentation/bloc/login/login_state.dart';
import 'package:chazapp/src/features/profile/presentation/bloc/profile/profile_bloc.dart';
import 'package:chazapp/src/features/profile/presentation/bloc/profile/profile_event.dart';
import 'package:chazapp/src/features/profile/presentation/bloc/profile/profile_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is! LoginSuccess) {
            context.go('/');
          }
        },
        child: BlocBuilder<LoginBloc, LoginState>(
          builder: (context, state) {
            if (state is! LoginSuccess) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            final token = (state).userEntity.token;

            return BlocProvider(
              create: (context) =>
                  sl<ProfileBloc>()..add(ProfileRequested(token)),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    child: BlocBuilder<ProfileBloc, ProfileState>(
                        builder: (context, state) {
                      // Si está cargando
                      if (state is ProfileLoading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      // Si cargó correctamente
                      else if (state is ProfileSuccess) {
                        return Center(
                          child: Column(
                            children: [
                              const Text('Profile Screen'),
                              Text('Email: ${state.profileEntity.email}'),
                              Text('UserID: ${state.profileEntity.idUser}'),
                              ElevatedButton(
                                onPressed: () {},
                                child: const Text("Crear Chaza"),
                              ),
                              const Text('Mis Chazas'),
                              state.chazas.isNotEmpty
                                  ? SizedBox(
                                      height: 200,
                                      child: ListView.builder(
                                        itemCount: state.chazas.length,
                                        itemBuilder: (context, index) {
                                          final chaza = state.chazas[index];
                                          return ListTile(
                                            title: Text(chaza.nombre),
                                            subtitle: Text(chaza.descripcion),
                                          );
                                        },
                                      ),
                                    )
                                  : const Text('No tienes chazas'),
                              ElevatedButton(
                                onPressed: () {
                                  context.go("/");
                                  context
                                      .read<LoginBloc>()
                                      .add(LogoutRequested());
                                },
                                child: const Text("Cerrar Sesión"),
                              )
                            ],
                          ),
                        );
                      }
                      // Si falló
                      else if (state is ProfileFailure) {
                        return const Center(
                          child: Text('Error al cargar el perfil'),
                        );
                      }

                      // Caso predeterminado
                      return Center(
                        child: Text(state.toString()),
                      );
                    }),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
