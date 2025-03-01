import 'package:chazapp/src/core/network/data_state.dart';
import 'package:chazapp/src/features/profile/domain/usecases/get_profile.dart';
import 'package:chazapp/src/features/profile/presentation/bloc/profile/profile_event.dart';
import 'package:chazapp/src/features/profile/presentation/bloc/profile/profile_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  // Casos de uso
  final GetProfileUseCase _getProfileUseCase;

  ProfileBloc(this._getProfileUseCase) : super(ProfileInitial()) {
    on<ProfileRequested>(_onProfileRequested);
  }

  Future<void> _onProfileRequested(
      ProfileRequested event, Emitter<ProfileState> emit) async {
    emit(ProfileLoading());
    final result = await _getProfileUseCase.call(params: event.token);

    if (result is DataSuccess) {
      emit(ProfileSuccess(result.data!));
    } else if (result is DataFailed) {
      emit(ProfileFailure(result.exception!));
    }
  }
}
