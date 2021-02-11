import 'package:dio/dio.dart';

class CustomDio {
  var _dio;

  customDio() {
    _dio = Dio();
  }

  Dio get instance => _dio;
}
