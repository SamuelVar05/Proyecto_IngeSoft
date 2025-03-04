import 'package:chazapp/src/core/network/api_endpoints.dart';
import 'package:chazapp/src/core/network/api_response.dart';
import 'package:chazapp/src/features/product_creation/data/models/product_model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'productos_api_service.g.dart';

@RestApi(baseUrl: baseUrl)
abstract class ProductosApiService {
  factory ProductosApiService(Dio dio) = _ProductosApiService;

  @GET(productosEndpoint)
  Future<HttpResponse<ApiResponse<List<ProductModel>>>> getProductos(
    @Header("Authorization") String token,
  );
}
