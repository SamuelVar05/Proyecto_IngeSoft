import 'dart:io';

import 'package:chazapp/src/core/network/data_state.dart';
import 'package:chazapp/src/features/profile/data/data_sources/remote/profile_api_service.dart';
import 'package:chazapp/src/features/profile/data/models/profile_model.dart';
import 'package:chazapp/src/features/profile/domain/enitites/profile_entity.dart';
import 'package:chazapp/src/features/profile/domain/repository/profile_repository.dart';
import 'package:dio/dio.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  // Services
  final ProfileApiService _profileApiService;

  ProfileRepositoryImpl(this._profileApiService);

  @override
  Future<DataState<ProfileEntity>> getProfile(String token) async {
    // Se realiza la petición al servidor
    final httpResponse = await _profileApiService.getProfile("Bearer $token");

    try{
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
}
