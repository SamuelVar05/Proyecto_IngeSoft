import 'package:chazapp/src/features/profile/presentation/bloc/profile/profile_bloc.dart';
import 'package:chazapp/src/features/profile/presentation/bloc/profile/profile_event.dart';
import 'package:chazapp/src/features/profile/presentation/bloc/profile/profile_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileBloc, ProfileState>(
      listener: (context, state) {},
      child: Scaffold(
        body: Builder(builder: (context) {
          context.read<ProfileBloc>().add(ProfileRequested());
          return const Center(
            child: Text('Profile Screen'),
          );
        }),
      ),
    );
  }
}
