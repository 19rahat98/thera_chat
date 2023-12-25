import 'package:dio/dio.dart';

/// сервис для авторизованной зоны
class AuthorizedApiService {
  AuthorizedApiService(this._httpClient);

  final Future<Dio> _httpClient;

  /// Получение данных юзера
  Future<Response> getUserDetail() async {
    final client = await _httpClient;
    return client.get<dynamic>('/profile');
  }
}
