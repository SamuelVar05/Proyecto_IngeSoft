import 'package:equatable/equatable.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object?> get props => [];
}

class RegisterRequested extends RegisterEvent {
  final String email;
  final String password;
  //TODO: Agrergar el nombre cuando se cambie la api
  // final String name;

  const RegisterRequested(this.email, this.password);

  @override
  List<Object?> get props => [email, password];
}
