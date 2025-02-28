import 'package:equatable/equatable.dart';

class ProfileEntity extends Equatable {
  final String email;

  const ProfileEntity({
    required this.email,
  });

  @override
  List<Object?> get props => [email];
}
