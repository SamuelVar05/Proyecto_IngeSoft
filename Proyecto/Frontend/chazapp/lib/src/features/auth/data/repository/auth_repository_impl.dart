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
        return DataFailed(
          DioException(
            error: httpResponse.response.statusMessage,
            response: httpResponse.response,
            type: DioExceptionType.badResponse,
            requestOptions: httpResponse.response.requestOptions,
          ),
        );
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }
}
