import 'package:chazapp/src/features/product_creation/domain/entities/category_entity.dart';

abstract class CategoryRepository {
  Future<List<CategoryEntity>> getCategories();
  Future<CategoryEntity> createCategory(String name, String description);
}
