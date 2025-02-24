import 'package:equatable/equatable.dart';

class RegisterEntity extends Equatable {
  final String email;
  final String userID;

  const RegisterEntity({required this.email, required this.userID});

  @override
  List<Object?> get props => [email, userID];
}
