class RegisterRequestEntity {
  //TODO: Corregir la api para que reciba el nombre también
  // final String name;
  
  final String email;
  final String password;

  const RegisterRequestEntity({required this.email, required this.password});
}
