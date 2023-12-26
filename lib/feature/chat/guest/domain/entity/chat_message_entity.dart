import 'package:theta_chat/common/constants/app_core_constant.dart';
import 'package:theta_chat/feature/chat/guest/data/dto/chat_message_dto.dart';

class ChatMessage {
  ChatMessage({
    required this.role,
    required this.message,
  });

  final String role;
  final String message;

  /// Factory method to create a ChatMessage entity from a ChatMessageDto.
  factory ChatMessage.fromDto(ChatMessageDto dto) {
    return ChatMessage(
      role: dto.role ?? CoreConstant.empty,
      message: dto.text ?? CoreConstant.empty,
    );
  }

  /// Создаем пустой мэсейдж для ассистента
  factory ChatMessage.emptyMessage() => ChatMessage(
        role: 'assistant',
        message: CoreConstant.empty,
      );

  /// Создает экземпял обьекта для сообщений юзера
  factory ChatMessage.userMessage(String text) => ChatMessage(
        role: 'user',
        message: text,
      );

  static List<ChatMessage> fromDtoList(List<ChatMessageDto>? dtoList) {
    return dtoList?.map(ChatMessage.fromDto).toList() ?? [];
  }

  /// Проверка, чея это сообщение
  bool get isAssistantMessage => role == 'assistant';
}
