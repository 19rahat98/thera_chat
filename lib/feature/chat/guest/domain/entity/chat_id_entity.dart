import 'package:theta_chat/common/constants/app_core_constant.dart';
import 'package:theta_chat/feature/chat/guest/data/dto/chat_id_dto.dart';

class ChatIdEntity {
  ChatIdEntity({
    this.chatId = CoreConstant.empty,
  });

  factory ChatIdEntity.fromDto(ChatIdDto? dto) => ChatIdEntity(
        chatId: dto?.chatId ?? CoreConstant.empty,
      );

  final String chatId;
}
