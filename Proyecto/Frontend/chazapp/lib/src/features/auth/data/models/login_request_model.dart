import 'package:chazapp/src/features/auth/domain/entities/login_request_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'login_request_model.g.dart';

@JsonSerializable()
class LoginRequestModel extends LoginRequestEntity {
  const LoginRequestModel({required super.email, required super.password});

  factory LoginRequestModel.fromJson(Map<String, dynamic> json) =>
      _$LoginRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$LoginRequestModelToJson(this);
}
