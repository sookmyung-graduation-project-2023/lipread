import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:lipread/services/token_service.dart';
import 'package:lipread/storage/secure_storage.dart';

class TokenInterceptors extends Interceptor {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    debugPrint('[test] REQUEST[${options.method}] => PATH: ${options.path}');
    final accessToken =
        await SecureStorage.storage.read(key: StorageKey.accessToken);
    options.headers['Authorization'] = 'Bearer $accessToken';
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    debugPrint(
        '[test] RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}');
    super.onResponse(response, handler);
  }

  @override
  Future onError(DioException err, ErrorInterceptorHandler handler) async {
    debugPrint(
        '[test] ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}');
    if (err.response?.statusCode == 401) {
      String newAccessToken = await TokenService.refreshToken();
      err.requestOptions.headers['Authorization'] = 'Bearer $newAccessToken';
    }
    super.onError(err, handler);
  }
}
