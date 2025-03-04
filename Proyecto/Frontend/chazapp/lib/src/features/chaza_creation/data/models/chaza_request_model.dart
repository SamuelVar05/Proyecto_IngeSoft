// ignore_for_file: non_constant_identifier_names

import 'package:chazapp/src/features/chaza_creation/domain/entity/chaza_request_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'chaza_request_model.g.dart';

@JsonSerializable()
class ChazaRequestModel extends ChazaRequestEntity {
  ChazaRequestModel(
      {required super.id_usuario,
      required super.nombre,
      required super.descripcion,
      super.ubicacion,
      super.foto_id});

  factory ChazaRequestModel.fromJson(Map<String, dynamic> json) =>
      _$ChazaRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$ChazaRequestModelToJson(this);
}
