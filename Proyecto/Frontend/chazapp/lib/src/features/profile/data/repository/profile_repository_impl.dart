import 'dart:io';

import 'package:chazapp/src/core/network/data_state.dart';
import 'package:chazapp/src/features/profile/data/data_sources/remote/profile_api_service.dart';
import 'package:chazapp/src/features/profile/data/models/chaza_model.dart';
import 'package:chazapp/src/features/profile/data/models/profile_model.dart';
import 'package:chazapp/src/features/profile/domain/repository/profile_repository.dart';
import 'package:dio/dio.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  // Services
  final ProfileApiService _profileApiService;

  ProfileRepositoryImpl(this._profileApiService);

  @override
  Future<DataState<ProfileModel>> getProfile(String token) async {
    // Se realiza la petición al servidor
    final httpResponse = await _profileApiService.getProfile("Bearer $token");

    try {
      // Si la petición fue exitosa
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        ProfileModel profile = httpResponse.data.data!;

        return DataSuccess(profile);
      } else {
        return DataFailed(
          DioException(
            error: "Error ${httpResponse.response.statusCode}",
            message: "Error en la petición",
            response: httpResponse.response,
            type: DioExceptionType.badResponse,
            requestOptions: httpResponse.response.requestOptions,
          ),
        );
      }
    } on DioException catch (e) {
      return DataFailed(
        DioException(
          error: "Error ${e.response?.statusCode}",
          message: "Error en la petición",
          response: e.response,
          type: DioExceptionType.badResponse,
          requestOptions: e.requestOptions,
        ),
      );
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
  Future<DataState<List<ChazaModel>>> getChazas(
      String token, String userId) async {
    

    try {
      final httpResponse =
        await _profileApiService.getChazas("Bearer $token", userId);
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        List<ChazaModel> chazas = httpResponse.data.data!;

        return DataSuccess(chazas);
      } else {
        return DataFailed(
          DioException(
            error: "Error ${httpResponse.response.statusCode}",
            message: "Error en la petición",
            response: httpResponse.response,
            type: DioExceptionType.badResponse,
            requestOptions: httpResponse.response.requestOptions,
          ),
        );
      }
    } on DioException catch (e) {
      print("Hola");
      if (e.response?.statusCode == HttpStatus.notFound) {
        print("hola. Estoy en la excepción");
        return const DataSuccess(
            []); // Si no hay chazas, se retorna una lista vacía (no es un error
      }
      return DataFailed(
        DioException(
          error: "Error ${e.response?.statusCode}",
          message: "Error en la petición",
          response: e.response,
          type: DioExceptionType.badResponse,
          requestOptions: e.requestOptions,
        ),
      );
    } on SocketException {
      return DataFailed(DioException(
        error: "No hay conexión a Internet.",
        requestOptions:
            RequestOptions(path: ''), // Se requiere un `RequestOptions`
        type: DioExceptionType.connectionError,
      ));
    } catch (e) {
      return DataFailed(DioException(
        error: "Error inesperado: ${e.toString()}",
        requestOptions: RequestOptions(path: ''),
        type: DioExceptionType.unknown,
      ));
    }
  }
}
