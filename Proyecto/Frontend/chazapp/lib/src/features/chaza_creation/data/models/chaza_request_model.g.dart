// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chaza_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChazaRequestModel _$ChazaRequestModelFromJson(Map<String, dynamic> json) =>
    ChazaRequestModel(
      idUsuario: json['idUsuario'] as String,
      nombre: json['nombre'] as String,
      descripcion: json['descripcion'] as String,
      ubicacion: json['ubicacion'] as String?,
      idPhoto: (json['idPhoto'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ChazaRequestModelToJson(ChazaRequestModel instance) =>
    <String, dynamic>{
      'idUsuario': instance.idUsuario,
      'nombre': instance.nombre,
      'descripcion': instance.descripcion,
      'ubicacion': instance.ubicacion,
      'idPhoto': instance.idPhoto,
    };
