import 'dart:async';

import 'package:chazapp/src/core/network/data_state.dart';
import 'package:chazapp/src/features/auth/domain/entities/login_request_entity.dart';
import 'package:chazapp/src/features/auth/domain/entities/user_entity.dart';
import 'package:chazapp/src/features/auth/domain/usecases/delete_token.dart';
import 'package:chazapp/src/features/auth/domain/usecases/get_token.dart';
import 'package:chazapp/src/features/auth/domain/usecases/login.dart';
import 'package:chazapp/src/features/auth/domain/usecases/save_token.dart';
import 'package:chazapp/src/features/auth/presentation/bloc/login/login_event.dart';
import 'package:chazapp/src/features/auth/presentation/bloc/login/login_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUseCase _loginUseCase;
  final GetTokenUseCase _getTokenUseCase;
  final DeleteTokenUseCase _deleteTokenUseCase;
  final SaveTokenUseCase _saveTokenUseCase;

  // El estado inicial será LoginInitial
  LoginBloc(this._loginUseCase, this._getTokenUseCase, this._deleteTokenUseCase,
      this._saveTokenUseCase)
      : super(LoginInitial()) {
    on<LoginRequested>(_onLoginRequested);
    on<CheckAuthStatus>(_onCheckAuthStatus);
    on<LogoutRequested>(_onLogoutRequested);
  }

  // Se llama al caso de uso para el inicio de sesión
  Future<void> _onLoginRequested(
      LoginRequested event, Emitter<LoginState> emit) async {
    final result = await _loginUseCase.call(
      params: LoginRequestEntity(email: event.email, password: event.password),
    );

    // Si el resultado es exitoso
    if (result is DataSuccess) {
      final user = result.data!;
      await _saveTokenUseCase.call(params: user.token);
      emit(LoginSuccess(result.data!));
    }

    // Si el resultado falló
    if (result is DataFailed) {
      emit(LoginFailure(result.exception!));
    }
  }

  Future<void> _onCheckAuthStatus(
      CheckAuthStatus event, Emitter<LoginState> emit) async {
    final result = await _getTokenUseCase.call();

    if (result != null) {
      emit(LoginSuccess(LoginEntity(token: result)));
    } else {
      emit(LoginInitial());
    }
  }

  Future<void> _onLogoutRequested(
      LogoutRequested event, Emitter<LoginState> emit) async {
    await _deleteTokenUseCase.call();
    emit(LoginInitial());
  }
}
