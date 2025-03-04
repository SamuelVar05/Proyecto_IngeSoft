import 'package:chazapp/src/core/network/data_state.dart';
import 'package:chazapp/src/core/usecase/usecase.dart';
import 'package:chazapp/src/features/home/domain/repository/productos_repository.dart';
import 'package:chazapp/src/features/product_creation/domain/entities/product_entity.dart';

class GetProductosUseCase implements UseCase<DataState<List<ProductEntity>>, String> {
  final ProductosRepository _productosRepository;

  GetProductosUseCase(this._productosRepository);
  
  @override
  Future<DataState<List<ProductEntity>>> call({String? params}) {
    if(params == null) {
      throw ArgumentError("Params cannot be null");
    }
    return _productosRepository.getProductos(params);
  }

  
}