import 'package:chazapp/src/features/profile/presentation/bloc/profile/profile_event.dart';
import 'package:chazapp/src/features/profile/presentation/bloc/profile/profile_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  // Casos de uso
  // TODO: Crear casos de uso

  ProfileBloc() : super(ProfileInitial()){
    on<ProfileRequested>(_onProfileRequested);
  }

  Future<void> _onProfileRequested(ProfileRequested event, Emitter<ProfileState> emit) async {
    print("hola");
  }
}