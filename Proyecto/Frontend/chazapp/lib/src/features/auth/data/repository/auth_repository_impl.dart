import 'dart:io';

import 'package:chazapp/src/core/network/data_state.dart';
import 'package:chazapp/src/features/auth/data/data_sources/remote/login_api_service.dart';
import 'package:chazapp/src/features/auth/data/models/login_request_model.dart';
import 'package:chazapp/src/features/auth/data/models/user_model.dart';
import 'package:chazapp/src/features/auth/domain/repository/auth_repository.dart';
import 'package:dio/dio.dart';

class AuthRepositoryImpl implements AuthRepository {
  final LoginApiService _loginApiService;

  AuthRepositoryImpl(this._loginApiService);

  @override
  Future<DataState<UserModel>> login(String email, String password) async {
    try {
      LoginRequestModel request =
          LoginRequestModel(email: email, password: password);
      final httpResponse = await _loginApiService.login(request);

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data);
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
      if (e.response?.statusCode == HttpStatus.unauthorized) {
        return DataFailed(DioException(
          error: "Error ${e.response?.statusCode}",
          message: "Usuario o contraseña incorrectos",
          response: e.response,
          type: DioExceptionType.badResponse,
          requestOptions: e.requestOptions,
        ));
      }
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
