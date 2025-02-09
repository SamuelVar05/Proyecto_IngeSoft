import '../../data/models/user_model.dart' show UserModel;

/// Repositorio de autenticación abstracto
abstract class AuthRepository {
  /// Método de inicio de sesión
  ///
  /// Retorna un [UserModel] con el token de usuario
  /// a partir de un [username] y [password]
  Future<UserModel> login(String username, String password);
}
