import 'package:chazapp/src/core/network/api_endpoints.dart';
import 'package:chazapp/src/core/network/api_response.dart';
import 'package:chazapp/src/features/product_creation/data/models/category_model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'category_api_service.g.dart';

@RestApi(baseUrl: baseUrl)
abstract class CategoryApiService {
  factory CategoryApiService(Dio dio) = _CategoryApiService;

  @GET("$categoriasEndpoint/list")
  Future<HttpResponse<ApiResponse<List<CategoryModel>>>> getCategories(@Header("Authorization") String token);

  @POST("$categoriasEndpoint/create")
  Future<HttpResponse<ApiResponse<CategoryModel>>> createCategory(
    @Header("Authorization") String token,
    @Body() Map<String, dynamic> body,
  );
}
