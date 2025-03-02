import 'package:chazapp/src/features/auth/data/models/user_model.dart';
import 'package:chazapp/src/features/auth/domain/entities/register_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'register_model.g.dart';

@JsonSerializable()
class RegisterModel extends RegisterEntity {
  @override
  @JsonKey(name: "user")
  final UserModel user; // Asegura que `user` sea del tipo `UserModel`

  @override
  @JsonKey(name: "token")
  final String token;

  const RegisterModel(this.user, this.token) : super(user: user, token: token);

  factory RegisterModel.fromJson(Map<String, dynamic> json) =>
      _$RegisterModelFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterModelToJson(this);
}
