import 'package:equatable/equatable.dart';

class RegisterEntity extends Equatable {
  final UserEntity user;
  final String token;

  const RegisterEntity({required this.user, required this.token});

  @override
  List<Object?> get props => [user, token];
}

class UserEntity extends Equatable {
  final String email;
  final String userid;

  const UserEntity({required this.email, required this.userid});

  @override
  List<Object?> get props => [email, userid];
}
