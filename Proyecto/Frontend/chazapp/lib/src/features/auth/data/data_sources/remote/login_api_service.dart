import 'package:chazapp/src/core/network/api_endpoints.dart';
import 'package:chazapp/src/core/network/api_response.dart';
import 'package:chazapp/src/features/auth/data/models/login_request_model.dart';
import 'package:chazapp/src/features/auth/data/models/login_model.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part "login_api_service.g.dart";

@RestApi(baseUrl: baseUrl)
abstract class LoginApiService {
  factory LoginApiService(Dio dio) = _LoginApiService;

  @POST(loginEndpoint)
  Future<HttpResponse<ApiResponse<LoginModel>>> login(
      @Body() LoginRequestModel body);
}
