// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chaza_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChazaModel _$ChazaModelFromJson(Map<String, dynamic> json) => ChazaModel(
      id: json['id'] as String,
      nombre: json['nombre'] as String,
      descripcion: json['descripcion'] as String,
      ubicacion: json['ubicacion'] as String?,
      fotoId: (json['fotoId'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ChazaModelToJson(ChazaModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nombre': instance.nombre,
      'descripcion': instance.descripcion,
      'ubicacion': instance.ubicacion,
      'fotoId': instance.fotoId,
    };
