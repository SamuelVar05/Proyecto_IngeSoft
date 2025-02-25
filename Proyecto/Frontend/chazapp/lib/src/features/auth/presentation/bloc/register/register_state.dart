import 'package:chazapp/src/features/auth/domain/entities/register_entity.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

abstract class RegisterState extends Equatable {
  const RegisterState();

  @override
  List<Object> get props => [];
}

class RegisterInitial extends RegisterState {}

class RegisterLoading extends RegisterState {}

class RegisterSuccess extends RegisterState {
  final RegisterEntity registerEntity;

  const RegisterSuccess(this.registerEntity);

  @override
  List<Object> get props => [registerEntity];
}

class RegisterFailure extends RegisterState {
  final DioException exception;

  const RegisterFailure(this.exception);

  @override
  List<Object> get props => [exception];
}