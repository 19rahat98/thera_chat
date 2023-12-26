import 'package:dio/dio.dart';

/// Сервис для взаимодействия с API в авторизованной зоне.
class AuthorizedApiService {
  /// Конструктор, принимающий экземпляр Dio в качестве зависимости.
  AuthorizedApiService(this._httpClient);

  /// Экземпляр Dio для выполнения HTTP-запросов.
  final Future<Dio> _httpClient;

  /// Получение данных о пользователе.
  ///
  /// Возвращает ответ сервера на GET-запрос к эндпоинту '/profile',
  /// который содержит информацию о пользователе.
  Future<Response> getUserDetail() async {
    final client = await _httpClient;
    return client.get<dynamic>('/profile');
  }

  /// Начало нового чата.
  ///
  /// Отправляет POST-запрос к эндпоинту '/chat/start' для инициации нового чата.
  /// Возвращает ответ сервера на запрос.
  Future<Response> startNewChat() async {
    final client = await _httpClient;
    return client.post<dynamic>('/chat/start');
  }

  /// Отправка сообщения в чат.
  ///
  /// Принимает [data] - данные сообщения в виде Map<String, dynamic>.
  /// Отправляет POST-запрос к эндпоинту '/chat/message' с данными сообщения.
  /// Возвращает ответ сервера на запрос.
  Future<Response> sendMessageToChat(Map<String, dynamic> data) async {
    final client = await _httpClient;
    return client.post<dynamic>(
      '/chat/message',
      data: data,
    );
  }

  /// Получение истории чата.
  ///
  /// Отправляет GET-запрос к эндпоинту '/chat/messages' для получения истории сообщений чата.
  /// Возвращает ответ сервера на запрос.
  Future<Response> getChatHistory() async {
    final client = await _httpClient;
    return client.get<dynamic>('/chat/messages');
  }
}
