import 'dart:async';
import 'package:dio/dio.dart';

/// сервис для неавторизованной зоны
class UnauthorizedApiService {
  UnauthorizedApiService(this._httpClient);

  final Future<Dio> _httpClient;

  /// авторизация
  Future<Response> signInWithEmail(Map<String, dynamic> data) async {
    final client = await _httpClient;
    return client.post<dynamic>('/auth/email', data: data);
  }

  /// авторизация
  Future<Response> signUp(Map<String, dynamic> data) async {
    final client = await _httpClient;
    return client.post<dynamic>('/registration', data: data);
  }

  /// обновление токена
  Future<Response> refreshToken(String refreshToken) async {
    final client = await _httpClient;
    return client.get<dynamic>('/token/refresh/$refreshToken}');
  }
}
