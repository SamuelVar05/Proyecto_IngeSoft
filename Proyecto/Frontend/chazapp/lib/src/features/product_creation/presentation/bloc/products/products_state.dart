import 'package:chazapp/src/features/product_creation/domain/entities/product_entity.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

abstract class ProductsState extends Equatable {
  const ProductsState();

  @override
  List<Object?> get props => [];
}

class ProductsInitial extends ProductsState {}

class ProductsLoading extends ProductsState {}

class ProductsSuccess extends ProductsState {
  final ProductEntity productEntity;

  const ProductsSuccess(this.productEntity);

  @override
  List<Object?> get props => [productEntity];
}

class ProductsFailure extends ProductsState {
  final DioException dioException;

  const ProductsFailure(this.dioException);

  @override
  List<Object> get props => [dioException];
}
