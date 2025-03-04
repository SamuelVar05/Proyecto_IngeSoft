import 'package:chazapp/src/features/product_creation/domain/entities/product_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product_model.g.dart';

@JsonSerializable()
class ProductModel extends ProductEntity {
  const ProductModel({
    required super.name,
    required super.price,
    required super.description,
    required super.chazaId,
    required super.categoryId,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductModelToJson(this);
}
