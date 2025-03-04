import 'package:equatable/equatable.dart';

abstract class CategoryEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetCategoriesEvent extends CategoryEvent {
  final String token;

  GetCategoriesEvent(this.token);

  @override
  List<Object?> get props => [token];
}

class CreateCategoryEvent extends CategoryEvent {
  final String token;
  final String name;
  final String description;

  CreateCategoryEvent(this.token, this.name, this.description);

  @override
  List<Object?> get props => [token, name, description];
}