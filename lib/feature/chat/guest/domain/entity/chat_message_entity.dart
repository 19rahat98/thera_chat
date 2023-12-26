import 'package:theta_chat/common/constants/app_core_constant.dart';
import 'package:theta_chat/feature/chat/guest/data/dto/chat_message_dto.dart';

class ChatMessage {
  ChatMessage({
    required this.role,
    required this.text,
  });

  final String role;
  final String text;

  /// Factory method to create a ChatMessage entity from a ChatMessageDto.
  factory ChatMessage.fromDto(ChatMessageDto dto) {
    return ChatMessage(
      role: dto.role ?? CoreConstant.empty,
      text: dto.text ?? CoreConstant.empty,
    );
  }

  static List<ChatMessage> fromDtoList(List<ChatMessageDto>? dtoList) {
    return dtoList?.map(ChatMessage.fromDto).toList() ?? [];
  }

  /// Проверка, чея это сообщение
  bool get isAssistantMessage => role == 'assistant';
}
