import 'package:chazapp/src/core/network/data_state.dart';
import 'package:chazapp/src/core/usecase/usecase.dart';
import 'package:chazapp/src/features/product_creation/domain/entities/category_entity.dart';
import 'package:chazapp/src/features/product_creation/domain/repository/category_repository.dart';

class CreateCategory
    implements UseCase<DataState<CategoryEntity>, Map<String, dynamic>> {
  final CategoryRepository _categoryRepository;

  CreateCategory(this._categoryRepository);

  @override
  Future<DataState<CategoryEntity>> call(
      {required Map<String, dynamic> params}) {
    final name = params['name'];
    final description = params['description'];
    final token = params['token'];

    return _categoryRepository.createCategory(token, name, description);
  }
}
