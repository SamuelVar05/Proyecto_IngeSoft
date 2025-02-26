import 'package:json_annotation/json_annotation.dart';

part 'api_response.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class ApiResponse<T> {
  final bool success;
  final String message;
  final T? data;

  ApiResponse({
    required this.success,
    required this.message,
    this.data,
  });

  // Método para la deserialización personalizada
  factory ApiResponse.fromJson(
      Map<String, dynamic> json, T Function(Object? json) fromJsonT) {
    return _$ApiResponseFromJson(json, fromJsonT);
  }

  // Método para la serialización
  Map<String, dynamic> toJson(Object Function(T value) toJsonT) {
    return _$ApiResponseToJson(this, toJsonT);
  }
}
