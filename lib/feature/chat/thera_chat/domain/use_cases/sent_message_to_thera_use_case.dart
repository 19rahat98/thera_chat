import 'package:theta_chat/common/domain/abstract/core_use_case.dart';
import 'package:theta_chat/di/service_locator.dart';
import 'package:theta_chat/feature/chat/guest/domain/entity/chat_entity.dart';
import 'package:theta_chat/feature/chat/guest/domain/entity/chat_message_entity.dart';
import 'package:theta_chat/feature/chat/thera_chat/data/repository/thera_chat_repository.dart';

/// Use case для отправки сообщения в чат.
///
/// Этот use case отвечает за отправку текстового сообщения от пользователя в чат.
/// Для отправки сообщения используется репозиторий [TheraChatRepository], который обеспечивает
/// абстракцию слоя данных.
class SendMessageToTheraChatUseCase extends CoreFutureUseCase<TheraMessageParam, ChatMessage> {
  // Инициализация репозитория через сервис-локатор (sl), обеспечивая разделение зависимостей.
  SendMessageToTheraChatUseCase() : _repository = sl();

  // Репозиторий, который занимается операциями, связанными с Th3ra чатом.
  final TheraChatRepository _repository;

  @override

  /// Выполнение use case для отправки сообщения.
  ///
  /// Принимает [param] - параметры сообщения, включая идентификатор сессии чата и текст сообщения.
  /// Возвращает Future, который разрешается в сущность [ChatEntity], представляющую отправленное сообщение.
  Future<ChatMessage> execute(TheraMessageParam param) async {
    // Вызов репозитория для отправки сообщения в Th3ra чат.
    final result = await _repository.sentMessageToChat(param.toJson());

    // Преобразование DTO в сущность ChatEntity.
    final message = ChatEntity.fromDto(result);
    return ChatMessage(role: 'assistant', message: message.text);
  }
}

/// Параметры сообщения пользователя для отправки в чат.
class TheraMessageParam {
  final String message; // Текст сообщения для отправки.

  TheraMessageParam({
    required this.message,
  });

  /// Преобразует параметры сообщения в JSON-формат для отправки.
  Map<String, dynamic> toJson() => {'message': message};
}
