import 'package:chazapp/src/core/network/data_state.dart';
import 'package:chazapp/src/features/home/domain/entity/producto_entity.dart';

abstract class ProductosRepository {
  Future<DataState<List<ProductoEntity>>> getProductos(String token);
}