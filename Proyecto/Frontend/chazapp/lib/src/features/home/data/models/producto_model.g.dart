// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'producto_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductoModel _$ProductoModelFromJson(Map<String, dynamic> json) =>
    ProductoModel(
      id: json['id'] as String,
      name: json['name'] as String,
      price: (json['price'] as num).toDouble(),
      description: json['description'] as String,
    );

Map<String, dynamic> _$ProductoModelToJson(ProductoModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'price': instance.price,
      'description': instance.description,
    };
