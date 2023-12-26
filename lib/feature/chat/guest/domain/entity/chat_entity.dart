import 'package:theta_chat/common/constants/app_core_constant.dart';
import 'package:theta_chat/feature/chat/guest/data/dto/chat_dto.dart';

class ChatEntity {
  ChatEntity({required this.text});

  final String text;

  /// Factory method to create a ChatMessage entity from a ChatMessageDto.
  factory ChatEntity.fromDto(ChatDto dto) {
    return ChatEntity(
      text: dto.text ?? CoreConstant.empty,
    );
  }
}
