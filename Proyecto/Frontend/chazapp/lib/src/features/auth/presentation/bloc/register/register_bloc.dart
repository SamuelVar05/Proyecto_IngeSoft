import 'package:chazapp/src/core/network/data_state.dart';
import 'package:chazapp/src/features/auth/domain/entities/register_request_entitity.dart';
import 'package:chazapp/src/features/auth/domain/usecases/register.dart';
import 'package:chazapp/src/features/auth/presentation/bloc/register/register_event.dart';
import 'package:chazapp/src/features/auth/presentation/bloc/register/register_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final RegisterUseCase _registerUseCase;

  // El estado inicial será RegisterInitial
  RegisterBloc(this._registerUseCase) : super(RegisterInitial()) {
    on<RegisterRequested>(_onRegisterRequested);
  }

  // Se llama al caso de uso para el registro
  Future<void> _onRegisterRequested(
      RegisterRequested event, Emitter<RegisterState> emit) async {
    final result = await _registerUseCase.call(
      params:
          RegisterRequestEntity(email: event.email, password: event.password),
    );

    // Si el resultado es exitoso
    if (result is DataSuccess) {
      emit(RegisterSuccess(result.data!));
    }

    // Si el resultado falló
    if (result is DataFailed) {
      emit(RegisterFailure(result.exception!));
    }
  }
}
