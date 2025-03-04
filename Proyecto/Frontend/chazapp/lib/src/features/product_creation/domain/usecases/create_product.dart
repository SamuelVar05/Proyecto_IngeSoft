import 'package:chazapp/src/core/network/data_state.dart';
import 'package:chazapp/src/core/usecase/usecase.dart';
import 'package:chazapp/src/features/product_creation/domain/entities/product_entity.dart';
import 'package:chazapp/src/features/product_creation/domain/repository/products_repository.dart';

class CreateProductUseCase
    implements UseCase<DataState<ProductEntity>, Map<String, dynamic>> {
  final ProductsRepository _productsRepository;

  CreateProductUseCase(this._productsRepository);

  @override
  Future<DataState<ProductEntity>> call(
      {required Map<String, dynamic> params}) {
    final String token = params['token'];
    final ProductEntity productEntity = params['productEntity'];

    return _productsRepository.createProduct(token, productEntity);
  }
}
