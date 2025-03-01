import 'package:chazapp/src/core/network/data_state.dart';
import 'package:chazapp/src/features/profile/domain/usecases/get_chazas.dart';
import 'package:chazapp/src/features/profile/domain/usecases/get_profile.dart';
import 'package:chazapp/src/features/profile/presentation/bloc/profile/profile_event.dart';
import 'package:chazapp/src/features/profile/presentation/bloc/profile/profile_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  // Casos de uso
  final GetProfileUseCase _getProfileUseCase;
  final GetChazasUseCase _getChazasUseCase;

  ProfileBloc(this._getProfileUseCase, this._getChazasUseCase)
      : super(ProfileInitial()) {
    on<ProfileRequested>(_onProfileRequested);
  }

  Future<void> _onProfileRequested(
      ProfileRequested event, Emitter<ProfileState> emit) async {
    emit(ProfileLoading());

    // Obtener perfil del usuario
    final profileResult = await _getProfileUseCase.call(params: event.token);

    if (profileResult is DataSuccess) {
      final profile = profileResult.data!;
      // Obtener chazas del usuario
      final chazasResult = await _getChazasUseCase.call(
          params: GetChazasParams(token: event.token, userId: profile.idUser));

      if (chazasResult is DataSuccess) {
        emit(ProfileSuccess(profile, chazasResult.data!));
      } else if (chazasResult is DataFailed) {
        emit(ProfileFailure(chazasResult.exception!));
      }
    } else if (profileResult is DataFailed) {
      emit(ProfileFailure(profileResult.exception!));
    }
  }
}
