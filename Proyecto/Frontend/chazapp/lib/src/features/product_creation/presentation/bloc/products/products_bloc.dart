import 'package:chazapp/src/core/network/data_state.dart';
import 'package:chazapp/src/features/product_creation/domain/entities/product_entity.dart';
import 'package:chazapp/src/features/product_creation/domain/usecases/create_product.dart';
import 'package:chazapp/src/features/product_creation/presentation/bloc/products/products_event.dart';
import 'package:chazapp/src/features/product_creation/presentation/bloc/products/products_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final CreateProductUseCase _createProductUseCase;

  ProductsBloc(this._createProductUseCase) : super(ProductsInitial()) {
    on<ProductCreationRequested>(_onProductCreationRequested);
  }

  Future<void> _onProductCreationRequested(
      ProductCreationRequested event, Emitter<ProductsState> emit) async {
    emit(ProductsLoading());
    final ProductEntity productEntity = ProductEntity(
      name: event.name,
      price: event.price,
      description: event.description,
      chazaId: event.chazaId,
      categoryId: event.categoryId,
    );

    final result = await _createProductUseCase.call(params: {
      "token": event.token,
      "productEntity": productEntity,
    });

    if (result is DataSuccess) {
      emit(ProductsSuccess(result.data!));
    } else if (result is DataFailed) {
      emit(ProductsFailure(result.exception!));
    }
  }
}
