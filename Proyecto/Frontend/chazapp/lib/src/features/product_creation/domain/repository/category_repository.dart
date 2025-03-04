import 'package:chazapp/src/features/product_creation/domain/entities/category_entity.dart';

abstract class CategoryRepository {
  Future<List<CategoryEntity>> getCategories(String token);
  Future<CategoryEntity> createCategory(String token, String name, String description);
}
