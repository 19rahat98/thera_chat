import 'package:theta_chat/common/domain/abstract/core_use_case.dart';
import 'package:theta_chat/di/service_locator.dart';
import 'package:theta_chat/feature/chat/guest/data/repository/guest_chat_repository.dart';
import 'package:theta_chat/feature/chat/guest/domain/entity/chat_entity.dart';

/// Use case для отправки сообщения в гостевой чат.
///
/// Этот use case отвечает за отправку текстового сообщения от пользователя в гостевой чат.
/// Для отправки сообщения используется репозиторий [GuestChatRepository], который обеспечивает
/// абстракцию слоя данных.
class SendMessageToGuestChatUseCase extends CoreFutureUseCase<UserMessageParam, ChatEntity> {
  // Инициализация репозитория через сервис-локатор (sl), обеспечивая разделение зависимостей.
  SendMessageToGuestChatUseCase() : _repository = sl();

  // Репозиторий, который занимается операциями, связанными с гостевым чатом.
  final GuestChatRepository _repository;

  @override

  /// Выполнение use case для отправки сообщения.
  ///
  /// Принимает [param] - параметры сообщения, включая идентификатор сессии чата и текст сообщения.
  /// Возвращает Future, который разрешается в сущность [ChatEntity], представляющую отправленное сообщение.
  Future<ChatEntity> execute(UserMessageParam param) async {
    // Вызов репозитория для отправки сообщения в гостевой чат.
    final result = await _repository.sentMessageToGuestChat(
      param.id,
      param.toJson(),
    );

    // Преобразование DTO в сущность ChatEntity.
    return ChatEntity.fromDto(result);
  }
}

/// Параметры сообщения пользователя для отправки в гостевой чат.
class UserMessageParam {
  final String id; // Идентификатор сессии или пользователя для чата.
  final String message; // Текст сообщения для отправки.

  UserMessageParam({
    required this.id,
    required this.message,
  });

  /// Преобразует параметры сообщения в JSON-формат для отправки.
  Map<String, dynamic> toJson() => {'message': message};
}
