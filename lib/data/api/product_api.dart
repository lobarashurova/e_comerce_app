
import 'package:injectable/injectable.dart';
import 'package:dio/dio.dart';

@injectable
class ProductApi{
  final Dio _dio;
  ProductApi(this._dio);
  
  
  Future<Response> fetchProductsData({int? limit, int? skip}){
    return _dio.get("products", queryParameters: {
      'limit': limit,
      'skip': skip
    });
  }
}