import 'package:chazapp/src/features/auth/domain/entities/register_request_entitity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'register_request_model.g.dart';

@JsonSerializable()
class RegisterRequestModel extends RegisterRequestEntity {
  const RegisterRequestModel({required super.email, required super.password});

  factory RegisterRequestModel.fromJson(Map<String, dynamic> json) =>
      _$RegisterRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterRequestModelToJson(this);
}
