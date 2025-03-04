// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chaza_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChazaRequestModel _$ChazaRequestModelFromJson(Map<String, dynamic> json) =>
    ChazaRequestModel(
      id_usuario: json['id_usuario'] as String,
      nombre: json['nombre'] as String,
      descripcion: json['descripcion'] as String,
      ubicacion: json['ubicacion'] as String?,
      foto_id: (json['foto_id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ChazaRequestModelToJson(ChazaRequestModel instance) =>
    <String, dynamic>{
      'id_usuario': instance.id_usuario,
      'nombre': instance.nombre,
      'descripcion': instance.descripcion,
      'ubicacion': instance.ubicacion,
      'foto_id': instance.foto_id,
    };
