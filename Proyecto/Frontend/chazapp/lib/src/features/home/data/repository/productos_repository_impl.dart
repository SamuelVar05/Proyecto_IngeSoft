import 'dart:io';

import 'package:chazapp/src/core/network/data_state.dart';
import 'package:chazapp/src/features/home/data/data_sources/remote/productos_api_service.dart';
import 'package:chazapp/src/features/home/domain/entity/producto_entity.dart';
import 'package:chazapp/src/features/home/domain/repository/productos_repository.dart';
import 'package:dio/dio.dart';

class ProductosRepositoryImpl implements ProductosRepository {
  final ProductosApiService _productosApiService;

  ProductosRepositoryImpl(this._productosApiService);

  @override
  Future<DataState<List<ProductoEntity>>> getProductos(String token) async {
    try {
      final httpResponse =
          await _productosApiService.getProductos("Bearer $token");

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        List<ProductoEntity> productos =
            httpResponse.data.data!.map((e) => e as ProductoEntity).toList();
        return DataSuccess(productos);
      } else {
        return const DataSuccess([]);
      }
    } on DioException catch (e) {
      // Si la petición fue exitosa pero las credenciales son inválidas
      if (e.response?.statusCode == HttpStatus.unauthorized) {
        return DataFailed(DioException(
          error: "Error ${e.response?.statusCode}",
          message: "Usuario o contraseña incorrectos",
          response: e.response,
          type: DioExceptionType.badResponse,
          requestOptions: e.requestOptions,
        ));
      }

      // Si la petición fue exitosa pero los campos enviados son inválidos
      if (e.response?.statusCode == HttpStatus.badRequest) {
        return DataFailed(DioException(
          error: "Error ${e.response?.statusCode}",
          message: "Error en los campos enviados. Intente nuevamente.",
          response: e.response,
          type: DioExceptionType.badResponse,
          requestOptions: e.requestOptions,
        ));
      }
      return DataFailed(e);
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
