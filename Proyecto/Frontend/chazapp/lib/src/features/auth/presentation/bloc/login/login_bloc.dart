import 'dart:async';

import 'package:chazapp/src/core/network/data_state.dart';
import 'package:chazapp/src/features/auth/domain/entities/login_request_entity.dart';
import 'package:chazapp/src/features/auth/domain/usecases/login.dart';
import 'package:chazapp/src/features/auth/presentation/bloc/login/login_event.dart';
import 'package:chazapp/src/features/auth/presentation/bloc/login/login_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUseCase _loginUseCase;

  // El estado inicial será LoginInitial
  LoginBloc(this._loginUseCase) : super(LoginInitial()) {
    on<LoginRequested>(_onLoginRequested);
  }

  // Se llama al caso de uso para el inicio de sesión
  Future<void> _onLoginRequested(
      LoginRequested event, Emitter<LoginState> emit) async {
    final result = await _loginUseCase.call(
      params: LoginRequestEntity(email: event.email, password: event.password),
    );

    // Si el resultado es exitoso
    if (result is DataSuccess) {
      emit(LoginSuccess(result.data!));
    }

    // Si el resultado falló
    if (result is DataFailed) {
      emit(LoginFailure(result.exception!));
    }
  }
}
