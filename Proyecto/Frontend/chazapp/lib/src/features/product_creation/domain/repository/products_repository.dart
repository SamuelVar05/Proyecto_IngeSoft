import 'package:chazapp/src/core/network/data_state.dart';
import 'package:chazapp/src/features/product_creation/domain/entities/product_entity.dart';

abstract class ProductsRepository {
  Future<DataState<ProductEntity>> createProduct(
      String token, ProductEntity product);
}
