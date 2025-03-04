import 'package:chazapp/src/core/network/api_endpoints.dart';
import 'package:chazapp/src/core/network/api_response.dart';
import 'package:chazapp/src/features/product_creation/data/models/product_model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'products_api_service.g.dart';

@RestApi(baseUrl: baseUrl)
abstract class ProductsApiService {
  factory ProductsApiService(Dio dio) = _ProductsApiService;

  @POST("$productosEndpoint/create")
  Future<HttpResponse<ApiResponse<ProductModel>>> createProduct(
    @Header("Authorization") String token,
    @Body() ProductModel body,
  );
}
