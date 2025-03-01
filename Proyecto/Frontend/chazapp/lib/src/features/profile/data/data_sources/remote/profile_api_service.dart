import 'package:chazapp/src/core/network/api_endpoints.dart';
import 'package:chazapp/src/core/network/api_response.dart';
import 'package:chazapp/src/features/profile/data/models/chaza_model.dart';
import 'package:chazapp/src/features/profile/data/models/profile_model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part "profile_api_service.g.dart";

@RestApi(baseUrl: baseUrl)
abstract class ProfileApiService {
  factory ProfileApiService(Dio dio) = _ProfileApiService;

  @GET(profileEndpoint)
  Future<HttpResponse<ApiResponse<ProfileModel>>> getProfile(
    @Header("Authorization") String token,
  );

  @GET(chazaEndpoint)
  Future<HttpResponse<ApiResponse<List<ChazaModel>>>> getChazas(
    @Header("Authorization") String token,
    @Path("userId") String userId,
  );
}
