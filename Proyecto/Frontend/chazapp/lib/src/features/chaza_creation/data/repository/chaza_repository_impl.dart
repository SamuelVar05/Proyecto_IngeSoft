import 'dart:io';

import 'package:chazapp/src/core/network/data_state.dart';
import 'package:chazapp/src/features/chaza_creation/data/data_sources/remote/chaza_creation_service.dart';
import 'package:chazapp/src/features/chaza_creation/data/models/chaza_request_model.dart';
import 'package:chazapp/src/features/chaza_creation/domain/repository/chaza_repository.dart';
import 'package:dio/dio.dart';

class ChazaRepositoryImpl implements ChazaRepository {
  final ChazaCreationService _chazaCreationService;

  ChazaRepositoryImpl(this._chazaCreationService);

  @override
  Future<DataState<void>> createChaza({
    required idUsuario,
    required nombre,
    required descripcion,
    ubicacion,
    idPhoto,
    required token,
  }) async {
    try {
      final chazaRequest = ChazaRequestModel(
        id_usuario: idUsuario,
        nombre: nombre,
        descripcion: descripcion,
        ubicacion: ubicacion,
        foto_id: idPhoto,
      );

      final httpResponse = await _chazaCreationService.createChaza(
          "Bearer $token", chazaRequest);

      if (httpResponse.response.statusCode == HttpStatus.created) {
        return const DataSuccess(null);
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
