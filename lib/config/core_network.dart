import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:theta_chat/common/network/bearer_token_interceptor.dart';

Future<Dio> createHttpClient(
  String baseUrl, {
  bool useLogger = true,
}) async {
  final dio = Dio();
  dio.options.baseUrl = baseUrl;
  dio.options.connectTimeout = 50000;
  dio.options.receiveTimeout = 30000;

  if (kDebugMode && useLogger) {
    dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
      ),
    );
  }

  (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (HttpClient client) {
    client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
    return client;
  };

  return dio;
}

Future<Dio> createAuthorizedHttpClient(String baseUrl) async {
  final dio = Dio();
  dio.options.baseUrl = baseUrl;
  dio.options.connectTimeout = 50000;
  dio.options.receiveTimeout = 30000;

  if (kDebugMode) {
    dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
      ),
    );
  }
  dio.interceptors.add(BearerTokenInterceptor(dio));

  (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (HttpClient client) {
    client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
    return client;
  };

  return dio;
}
