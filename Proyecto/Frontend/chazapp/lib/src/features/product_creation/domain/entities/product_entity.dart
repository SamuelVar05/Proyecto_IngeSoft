import 'package:equatable/equatable.dart';

class ProductEntity extends Equatable {
  final String name;
  final double price;
  final String? barcode;
  final String description;
  final String chazaId;
  final String categoryId;

  const ProductEntity({
    required this.name,
    required this.price,
    this.barcode,
    required this.description,
    required this.chazaId,
    required this.categoryId,
  });

  @override
  List<Object?> get props =>
      [name, price, barcode, description, chazaId, categoryId];
}
