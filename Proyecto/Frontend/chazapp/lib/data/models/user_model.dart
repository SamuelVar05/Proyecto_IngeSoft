/// Modelo de usuario
class UserModel {
  /// Token de usuario
  final String token;

  /// Constructor
  UserModel({required this.token});

  /// Constructor factory a partir de un json
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(token: json["token"]);
  }

  /// Generador de json
  Map<String, dynamic> toJson() {
    return {"token": token};
  }
}
