import 'package:theta_chat/common/network/unauthorized_api_service.dart';
import 'package:theta_chat/di/service_locator.dart';
import 'package:theta_chat/feature/chat/guest/data/dto/chat_dto.dart';
import 'package:theta_chat/feature/chat/guest/data/dto/chat_id_dto.dart';
import 'package:theta_chat/feature/chat/guest/data/dto/chat_message_dto.dart';
import 'package:theta_chat/utils/http_call_utils.dart';

class GuestChatRepository {
  GuestChatRepository() : _apiService = sl();

  final UnauthorizedApiService _apiService;

  /// Создать новый гостевой чат
  Future<ChatIdDto> startNewGuestChat() async {
    return safeApiCall<ChatIdDto>(
      _apiService.startGuestChat(),
      ChatIdDto.fromJson,
    );
  }

  /// Получить историю гостевого чата
  Future<List<ChatMessageDto>> getGuestChatHistory(String id) async {
    return safeApiCallList<List<ChatMessageDto>>(
      _apiService.guestChatHistory(id),
      ChatMessageDto.fromJsonList,
    );
  }

  /// Отправить сообщение ассистенту по гостевому чату
  Future<ChatDto> sentMessageToGuestChat(String id, Map<String, dynamic> data) async {
    return safeApiCall<ChatDto>(
      _apiService.sendMessageForGuestChatById(id, data),
      ChatDto.fromJson,
    );
  }
}
