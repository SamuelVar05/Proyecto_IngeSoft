import 'package:chazapp/src/features/profile/domain/enitites/profile_entity.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileSuccess extends ProfileState {
  final ProfileEntity profileEntity;

  const ProfileSuccess(this.profileEntity);

  @override
  List<Object> get props => [profileEntity];
}

class ProfileFailure extends ProfileState {
  final DioException exception;

  const ProfileFailure(this.exception);

  @override
  List<Object> get props => [exception];
}
