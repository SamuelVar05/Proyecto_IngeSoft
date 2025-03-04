import 'package:chazapp/src/core/network/data_state.dart';
import 'package:chazapp/src/core/usecase/usecase.dart';
import 'package:chazapp/src/features/product_creation/domain/entities/category_entity.dart';
import 'package:chazapp/src/features/product_creation/domain/repository/category_repository.dart';

class GetCategoriesUseCase implements UseCase<DataState<List<CategoryEntity>>, String> {
  final CategoryRepository _categoryRepository;

  GetCategoriesUseCase(this._categoryRepository);

  @override
  Future<DataState<List<CategoryEntity>>> call({required String params}) {
    return _categoryRepository.getCategories(params);
  }
}