import 'package:dio/dio.dart';
import 'failure.dart';

Failure responseError(DioError error) {
  int code = int.parse(error.response?.data['cod'].toString() ?? "500");
  return Failure(code, error.response?.data['message']);
}
