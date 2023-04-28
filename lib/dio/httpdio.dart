import 'package:banana/dio/custominterceptors.dart';
import 'package:dio/dio.dart';

class HttpDio {
  HttpDio._();
  static final instance = HttpDio._();
  Dio hhtp = addInterceptors();

  static Dio addInterceptors() {
    final dio = Dio();

    final optionss = BaseOptions(
      baseUrl: 'https://dummyjson.com/',
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 8),
    );
    dio.interceptors.add(CustomerInterceptors());
    dio.options = optionss;

    return dio;
  }
}
