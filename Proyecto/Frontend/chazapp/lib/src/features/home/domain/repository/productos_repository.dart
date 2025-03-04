import 'package:chazapp/src/features/home/domain/entity/producto_entity.dart';

abstract class ProductosRepository {
  Future<List<ProductoEntity>> getProductos();
}