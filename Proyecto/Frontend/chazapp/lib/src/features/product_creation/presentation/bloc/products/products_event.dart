import 'package:equatable/equatable.dart';

abstract class ProductsEvent extends Equatable {
  const ProductsEvent();

  @override
  List<Object> get props => [];
}

class ProductCreationRequested extends ProductsEvent {
  final String name;
  final double price;
  final String description;
  final String chazaId;
  final String categoryId;

  final String token;

  const ProductCreationRequested({
    required this.name,
    required this.price,
    required this.description,
    required this.chazaId,
    required this.categoryId,
    required this.token,
  });
}
