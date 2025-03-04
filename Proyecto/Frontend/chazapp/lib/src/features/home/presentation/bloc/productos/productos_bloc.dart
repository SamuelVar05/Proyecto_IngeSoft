import 'package:chazapp/src/core/network/data_state.dart';
import 'package:chazapp/src/features/home/domain/usecases/get_productos.dart';
import 'package:chazapp/src/features/home/presentation/bloc/productos/productos_event.dart';
import 'package:chazapp/src/features/home/presentation/bloc/productos/productos_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductosBloc extends Bloc<ProductosEvent, ProductosState> {
  final GetProductosUseCase _getProductosUseCase;

  ProductosBloc(this._getProductosUseCase) : super(ProductosInitial()) {
    on<LoadProductsEvent>(_onLoadProducts);
  }

  void _onLoadProducts(LoadProductsEvent event, Emitter<ProductosState> emit) async {
    emit(ProductosLoading());
    
    final productosResult = await _getProductosUseCase.call(params: event.token);

    if(productosResult is DataSuccess) {
      emit(ProductosLoaded(productos: productosResult.data!));
    } else if(productosResult is DataFailed) {
      emit(ProductosError(exception: productosResult.exception!));
    }
  }
}
