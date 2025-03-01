import 'package:chazapp/src/features/profile/domain/enitites/chaza_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'chaza_model.g.dart';

@JsonSerializable()
class ChazaModel extends ChazaEntity {
  const ChazaModel({
    required super.id,
    required super.nombre,
    required super.descripcion,
    super.ubicacion,
    super.fotoId,
  });

  factory ChazaModel.fromJson(Map<String, dynamic> json) =>
      _$ChazaModelFromJson(json);

  Map<String, dynamic> toJson() => _$ChazaModelToJson(this);
}
