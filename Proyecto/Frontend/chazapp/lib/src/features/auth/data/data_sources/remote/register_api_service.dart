import 'package:chazapp/src/core/network/api_response.dart';
import 'package:chazapp/src/features/auth/data/models/register_model.dart';
import 'package:chazapp/src/features/auth/data/models/register_request_model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:chazapp/src/core/network/api_endpoints.dart';

part 'register_api_service.g.dart';

@RestApi(baseUrl: baseUrl)
abstract class RegisterApiService {
  factory RegisterApiService(Dio dio) = _RegisterApiService;

  @POST(registerEndpoint)
  Future<HttpResponse<ApiResponse<RegisterModel>>> register(
      @Body() RegisterRequestModel body);
}
