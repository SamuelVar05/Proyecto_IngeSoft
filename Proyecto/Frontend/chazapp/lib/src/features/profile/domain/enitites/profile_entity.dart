import 'package:equatable/equatable.dart';

class ProfileEntity extends Equatable {
  final String email;
  final String idUser;

  const ProfileEntity({
    required this.email,
    required this.idUser,
  });

  @override
  List<Object?> get props => [email, idUser];
}
