import 'package:chazapp/src/features/auth/domain/entities/login_entity.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final LoginEntity userEntity;

  const LoginSuccess(this.userEntity);

  @override
  List<Object> get props => [userEntity];
}

class LoginFailure extends LoginState {
  final DioException exception;

  const LoginFailure(this.exception);

  @override
  List<Object> get props => [exception];
}

class NoToken extends LoginState {}
