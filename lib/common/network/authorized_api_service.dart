import 'package:dio/dio.dart';

/// сервис для авторизованной зоны
class AuthorizedApiService {
  AuthorizedApiService(this._httpClient);

  final Future<Dio> _httpClient;
}
