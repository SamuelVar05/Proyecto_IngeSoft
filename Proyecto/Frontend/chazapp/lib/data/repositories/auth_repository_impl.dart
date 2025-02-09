import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../domain/repositories/auth_repository.dart' show AuthRepository;
import '../models/user_model.dart' show UserModel;

/// Implementación del repositorio de autenticación
class AuthRepositoryImpl implements AuthRepository {
  /// URL base de la API
  final String baseUrl;

  /// Constructor
  AuthRepositoryImpl({required this.baseUrl});

  /// Inicio de sesión
  @override
  Future<UserModel> login(String email, String password) async {
    final url = Uri.parse("$baseUrl/auth/login");

    // Petición POST
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"email": email, "password": password}),
    );

    // Si la petición fue exitosa
    if (response.statusCode == 200) {
      return UserModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Error al iniciar sesión");
    }
  }
}
