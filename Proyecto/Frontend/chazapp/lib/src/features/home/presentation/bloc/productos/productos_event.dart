import 'package:equatable/equatable.dart';

abstract class ProductosEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadProductsEvent extends ProductosEvent {
  final String token;

  LoadProductsEvent({required this.token});
}
