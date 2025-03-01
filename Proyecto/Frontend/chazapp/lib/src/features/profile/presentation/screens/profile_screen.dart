import 'package:chazapp/injection_container.dart';
import 'package:chazapp/src/features/auth/presentation/bloc/login/login_bloc.dart';
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
    final token = context.select<LoginBloc, String>((bloc) {
      final state = bloc.state;
      if (state is LoginSuccess) {
        return state.userEntity.token;
      }
      throw Exception('No se pudo obtener el token');
    });

    return BlocProvider(
      create: (context) => sl<ProfileBloc>()..add(ProfileRequested(token)),
      child: Scaffold(
        body: BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
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
      ),
    );
  }
}
