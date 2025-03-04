import 'package:chazapp/src/core/network/data_state.dart';
import 'package:chazapp/src/features/product_creation/domain/entities/category_entity.dart';

abstract class CategoryRepository {
  Future<DataState<List<CategoryEntity>>> getCategories(String token);
  Future<DataState<CategoryEntity>> createCategory(
      String token, String name, String description);
}
