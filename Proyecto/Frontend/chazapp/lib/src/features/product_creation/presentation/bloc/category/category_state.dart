import 'package:chazapp/src/features/product_creation/domain/entities/category_entity.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

abstract class CategoryState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CategoryInitialState extends CategoryState {}

class CategoryLoadingState extends CategoryState {}

class CategoryLoadedState extends CategoryState {
  final List<CategoryEntity> categories;

  CategoryLoadedState(this.categories);

  @override
  List<Object?> get props => [categories];
}

class CategoryErrorState extends CategoryState {
  final DioException dioException;

  CategoryErrorState(this.dioException);

  @override
  List<Object?> get props => [dioException];
}

class CategoryCreatedState extends CategoryState {
  final CategoryEntity category;

  CategoryCreatedState(this.category);

  @override
  List<Object?> get props => [category];
}