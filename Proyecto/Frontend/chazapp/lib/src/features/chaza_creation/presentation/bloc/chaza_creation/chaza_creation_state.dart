import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

abstract class ChazaCreationState extends Equatable {
  const ChazaCreationState();

  @override
  List<Object> get props => [];
}

class ChazaCreationInitial extends ChazaCreationState {}

class ChazaCreationLoading extends ChazaCreationState {}

class ChazaCreationSuccess extends ChazaCreationState {}

class ChazaCreationFailure extends ChazaCreationState {
  final DioException dioException;

  const ChazaCreationFailure(this.dioException);

  @override
  List<Object> get props => [dioException];
}
