import 'package:chazapp/src/features/home/domain/entity/producto_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'producto_model.g.dart';

@JsonSerializable()
class ProductoModel extends ProductoEntity {

  const ProductoModel({
    required super.id,
    required super.name,
    required super.price,
    required super.description,
  });

  factory ProductoModel.fromJson(Map<String, dynamic> json) =>
      _$ProductoModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductoModelToJson(this);
  
}
