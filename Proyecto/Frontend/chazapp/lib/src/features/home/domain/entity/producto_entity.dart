import 'package:equatable/equatable.dart';

class ProductoEntity extends Equatable {
  final String id;
  final String name;
  final double price;
  final String description;

  const ProductoEntity({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
  });

  @override
  List<Object?> get props => [id, name, price, description];
}