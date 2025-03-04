import 'package:chazapp/src/core/network/data_state.dart';
import 'package:chazapp/src/features/chaza_creation/domain/entity/chaza_request_entity.dart';
import 'package:chazapp/src/features/chaza_creation/domain/usecases/create_chaza.dart';
import 'package:chazapp/src/features/chaza_creation/presentation/bloc/chaza_creation/chaza_creation_event.dart';
import 'package:chazapp/src/features/chaza_creation/presentation/bloc/chaza_creation/chaza_creation_state.dart';
import 'package:chazapp/src/features/profile/domain/usecases/get_profile.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChazaCreationBloc extends Bloc<ChazaCreationEvent, ChazaCreationState> {
  final CreateChazaUseCase _createChazaUseCase;
  final GetProfileUseCase _getProfileUseCase;

  ChazaCreationBloc(this._createChazaUseCase, this._getProfileUseCase)
      : super(ChazaCreationInitial()) {
    on<ChazaCreationRequested>(_onChazaCreationRequested);
  }

  Future<void> _onChazaCreationRequested(
      ChazaCreationRequested event, Emitter<ChazaCreationState> emit) async {
    emit(ChazaCreationLoading());
    final profileResponse = await _getProfileUseCase.call(params: event.token);
    if (profileResponse is DataSuccess) {
      final profile = profileResponse.data!;

      ChazaRequestEntity chazaRequestEntity = ChazaRequestEntity(
          idUsuario: profile.idUser,
          nombre: event.nombre,
          descripcion: event.descripcion,
          ubicacion: event.ubicacion);
      final result = await _createChazaUseCase.call(params: {
        "chazaRequestEntity": chazaRequestEntity,
        "token": event.token,
      });

      if (result is DataSuccess) {
        emit(ChazaCreationSuccess());
      }

      if (result is DataFailed) {
        emit(ChazaCreationFailure(result.exception!));
      }
    } else if (profileResponse is DataFailed) {
      emit(ChazaCreationFailure(profileResponse.exception!));
    }
  }
}
