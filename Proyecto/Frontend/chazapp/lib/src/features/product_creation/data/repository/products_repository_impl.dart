import 'dart:io';

import 'package:chazapp/src/core/network/data_state.dart';
import 'package:chazapp/src/features/product_creation/data/data_sources/remote/products_api_service.dart';
import 'package:chazapp/src/features/product_creation/data/models/product_model.dart';
import 'package:chazapp/src/features/product_creation/domain/entities/product_entity.dart';
import 'package:chazapp/src/features/product_creation/domain/repository/products_repository.dart';
import 'package:dio/dio.dart';

class ProductsRepositoryImpl implements ProductsRepository {
  final ProductsApiService _productsApiService;

  ProductsRepositoryImpl(this._productsApiService);

  @override
  Future<DataState<ProductEntity>> createProduct(
      String token, ProductEntity product) async {
    try {
      final httpResponse = await _productsApiService.createProduct(
          "Bearer $token", product.toModel());
      if (httpResponse.response.statusCode == HttpStatus.created) {
        ProductModel product = httpResponse.data.data!;
        return DataSuccess(product);
      } else {
        return DataFailed(DioException(
          error: "Error ${httpResponse.response.statusCode}",
          message: "Error en la petición",
          response: httpResponse.response,
          type: DioExceptionType.badResponse,
          requestOptions: httpResponse.response.requestOptions,
        ));
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == HttpStatus.badRequest) {
        return DataFailed(DioException(
          error: "Error ${e.response?.statusCode}",
          message: "Campos inválidos",
          response: e.response,
          type: DioExceptionType.badResponse,
          requestOptions: e.requestOptions,
        ));
      }

      return DataFailed(DioException(
        error: "Error ${e.response?.statusCode}",
        message: "Error en la petición",
        response: e.response,
        type: DioExceptionType.badResponse,
        requestOptions: e.requestOptions,
      ));
    } on SocketException {
      // Si no hay conexión a Internet
      return DataFailed(DioException(
        error: "No hay conexión a Internet.",
        requestOptions:
            RequestOptions(path: ''), // Se requiere un `RequestOptions`
        type: DioExceptionType.connectionError,
      ));
    } catch (e) {
      // Si ocurre un error inesperado
      return DataFailed(DioException(
        error: "Error inesperado: ${e.toString()}",
        requestOptions: RequestOptions(path: ''),
        type: DioExceptionType.unknown,
      ));
    }
  }
}
