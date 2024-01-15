import 'dart:async';
import 'package:dio/dio.dart';

/// сервис для неавторизованной зоны
class UnauthorizedApiService {
  UnauthorizedApiService(this._httpClient);

  final Future<Dio> _httpClient;

  /// -------------- AUTHORIZATION -------------- ///

  /// авторизация
  Future<Response> signInWithEmail(Map<String, dynamic> data) async {
    final client = await _httpClient;
    return client.post<dynamic>('/auth/email', data: data);
  }

  /// авторизация
  Future<Response> signInWithPhone(Map<String, dynamic> data) async {
    final client = await _httpClient;
    return client.post<dynamic>('/auth/phone', data: data);
  }

  /// авторизация
  Future<Response> signUp(Map<String, dynamic> data) async {
    final client = await _httpClient;
    return client.post<dynamic>('/register', data: data);
  }

  /// обновление токена
  Future<Response> refreshToken(String refreshToken) async {
    final client = await _httpClient;
    return client.get<dynamic>('/token/refresh/$refreshToken');
  }

  /// -------------- GUEST CHAT -------------- ///

  /// Начать гостевой час с ботом
  /// Возврощяем ID для нового чата
  Future<Response> startGuestChat() async {
    final client = await _httpClient;
    return client.post<dynamic>('/chat/anon/start');
  }

  /// Отправить сообщение гостевому чату по [id]
  Future<Response> sendMessageForGuestChatById(String id, Map<String, dynamic> data) async {
    final client = await _httpClient;
    return client.post<dynamic>(
      '/chat/anon/$id/message',
      data: data,
    );
  }

  /// Получить историю ананимного чата по [id]
  Future<Response> guestChatHistory(String id) async {
    final client = await _httpClient;
    return client.get<dynamic>('/chat/anon/$id/messages');
  }
}
