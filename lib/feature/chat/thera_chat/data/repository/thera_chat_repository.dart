import 'package:theta_chat/common/network/authorized_api_service.dart';
import 'package:theta_chat/di/service_locator.dart';
import 'package:theta_chat/feature/chat/guest/data/dto/chat_dto.dart';
import 'package:theta_chat/feature/chat/guest/data/dto/chat_id_dto.dart';
import 'package:theta_chat/feature/chat/guest/data/dto/chat_message_dto.dart';
import 'package:theta_chat/utils/http_call_utils.dart';

/// Репозиторий для работы с гостевым чатом.
class TheraChatRepository {
  /// Конструктор, инициализирующий сервис API.
  TheraChatRepository() : _apiService = sl();

  /// Сервис API для выполнения запросов к серверу.
  final AuthorizedApiService _apiService;

  /// Начать новый чат.
  ///
  /// Выполняет запрос к серверу для начала нового чата и возвращает идентификатор чата.
  /// Возвращает [ChatIdDto] с данными идентификатора чата.
  Future<ChatIdDto> startNewtChat() async {
    return safeApiCall<ChatIdDto>(
      _apiService.startNewChat(),
      ChatIdDto.fromJson,
    );
  }

  /// Получить историю чата.
  ///
  /// Выполняет запрос к серверу для получения истории сообщений чата.
  /// Возвращает список объектов [ChatMessageDto] с данными сообщений чата.
  Future<List<ChatMessageDto>> getChatHistory() async {
    return safeApiCallList<List<ChatMessageDto>>(
      _apiService.getChatHistory(),
      ChatMessageDto.fromJsonList,
    );
  }

  /// Отправить сообщение в Thera чат.
  ///
  /// [data] содержит данные сообщения.
  /// Отправляет сообщение на сервер и возвращает ответ сервера в виде объекта [ChatDto].
  Future<ChatDto> sentMessageToChat(Map<String, dynamic> data) async {
    return safeApiCall<ChatDto>(
      _apiService.sendMessageToChat(data),
      ChatDto.fromJson,
    );
  }
}
