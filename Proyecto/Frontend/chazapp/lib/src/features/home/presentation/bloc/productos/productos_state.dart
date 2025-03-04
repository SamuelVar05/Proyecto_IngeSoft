import 'package:chazapp/src/features/product_creation/domain/entities/product_entity.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

abstract class ProductosState extends Equatable {
  @override
  List<Object> get props => [];
}

class ProductosInitial extends ProductosState {}

class ProductosLoading extends ProductosState {}

class ProductosLoaded extends ProductosState {
  final List<ProductEntity> productos;

  ProductosLoaded({required this.productos});

  @override
  List<Object> get props => [productos];
}

class ProductosError extends ProductosState {
  final DioException exception;

  ProductosError({required this.exception});

  @override
  List<Object> get props => [exception];
}