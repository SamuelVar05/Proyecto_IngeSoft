import 'dart:io';

import 'package:chazapp/src/core/network/data_state.dart';
import 'package:chazapp/src/features/auth/data/data_sources/remote/login_api_service.dart';
import 'package:chazapp/src/features/auth/data/data_sources/remote/register_api_service.dart';
import 'package:chazapp/src/features/auth/data/models/login_request_model.dart';
import 'package:chazapp/src/features/auth/data/models/register_model.dart';
import 'package:chazapp/src/features/auth/data/models/register_request_model.dart';
import 'package:chazapp/src/features/auth/data/models/login_model.dart';
import 'package:chazapp/src/features/auth/domain/repository/auth_repository.dart';
import 'package:dio/dio.dart';

class AuthRepositoryImpl implements AuthRepository {
  final LoginApiService
      _loginApiService; // Se inyecta la dependencia de LoginApiService
  final RegisterApiService
      _registerApiService; // Se inyecta la dependencia de RegisterApiService

  AuthRepositoryImpl(this._loginApiService, this._registerApiService);

  @override
  Future<DataState<LoginModel>> login(String email, String password) async {
    try {
      // Se crea un objeto de tipo LoginRequestModel con los datos enviados
      LoginRequestModel request =
          LoginRequestModel(email: email, password: password);

      // Se realiza la petición al servidor
      final httpResponse = await _loginApiService.login(request);

      final loginResponse = httpResponse.data;

      // Si la petición fue exitosa
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        LoginModel user = loginResponse.data!;

        return DataSuccess(user);
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

  @override
  Future<DataState<RegisterModel>> register(
      String email, String password) async {
    try {
      // Se crea un objeto de tipo RegisterRequestModel con los datos enviados
      RegisterRequestModel request =
          RegisterRequestModel(email: email, password: password);

      // Se realiza la petición al servidor
      final httpResponse = await _registerApiService.register(request);

      final registerResponse = httpResponse.data;

      // Si la petición fue exitosa
      if (httpResponse.response.statusCode == HttpStatus.created) {
        return DataSuccess(registerResponse.data!);
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
      final statusCode = e.response?.statusCode;
      // Si la petición fue exitosa pero los campos enviados son inválidos
      if (statusCode == HttpStatus.badRequest) {
        return DataFailed(DioException(
          error: "Error ${e.response?.statusCode}",
          message: "El usuario ya existe",
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
