import 'dart:io';

import 'package:chazapp/src/core/network/data_state.dart';
import 'package:chazapp/src/features/product_creation/data/data_sources/remote/category_api_service.dart';
import 'package:chazapp/src/features/product_creation/domain/entities/category_entity.dart';
import 'package:chazapp/src/features/product_creation/domain/repository/category_repository.dart';
import 'package:dio/dio.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final CategoryApiService _categoryApiService;

  CategoryRepositoryImpl(this._categoryApiService);

  @override
  Future<DataState<CategoryEntity>> createCategory(
      String token, String name, String description) async {
    final request = {
      "name": name,
      "description": description,
    };

    try {
      final httpResponse =
          await _categoryApiService.createCategory("Bearer $token", request);
      if (httpResponse.response.statusCode == HttpStatus.created) {
        CategoryEntity category = httpResponse.data.data!;
        return DataSuccess(category);
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

  @override
  Future<DataState<List<CategoryEntity>>> getCategories(String token) async {
    try {
      final httpResponse =
          await _categoryApiService.getCategories("Bearer $token");
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        List<CategoryEntity> categories = httpResponse.data.data!;
        return DataSuccess(categories);
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
