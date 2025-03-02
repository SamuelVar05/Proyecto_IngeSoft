import 'package:chazapp/src/core/network/api_response.dart';
import 'package:chazapp/src/features/chaza_creation/data/models/chaza_request_model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:chazapp/src/core/network/api_endpoints.dart';

part 'chaza_creation_service.g.dart';

@RestApi(baseUrl: baseUrl)
abstract class ChazaCreationService {
  factory ChazaCreationService(Dio dio) = _ChazaCreationService;

  @POST(chazaCreationEndpoint)
  Future<HttpResponse<ApiResponse<dynamic>>> createChaza(
      @Body() ChazaRequestModel body);
}
