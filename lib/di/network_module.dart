import 'package:dio/dio.dart';
import 'package:e_comerce_app/common/constants/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';


@module
abstract class NetworkModule {
  Dio dio() {
    final dio = Dio();
    dio.options.contentType = "application/json";

    dio.options.baseUrl = Constants.baseUrl;


    dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: kDebugMode,
        requestBody: kDebugMode,
        responseBody: kDebugMode,
        responseHeader: kDebugMode,
        error: kDebugMode,
        compact: true,
        maxWidth: 90,
      ),
    );

    return dio;
  }
}
