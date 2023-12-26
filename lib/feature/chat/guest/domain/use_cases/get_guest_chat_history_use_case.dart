import 'package:theta_chat/common/domain/abstract/core_use_case.dart';
import 'package:theta_chat/di/service_locator.dart';
import 'package:theta_chat/feature/chat/guest/data/repository/guest_chat_repository.dart';
import 'package:theta_chat/feature/chat/guest/domain/entity/chat_message_entity.dart';

/// Use case для получения истории гостевого чата.
///
/// Этот use case отвечает за получение данных о предыдущих сообщениях в гостевом чате.
/// Для получения данных он использует [GuestChatRepository], который является абстракцией
/// слоя данных и позволяет изолировать бизнес-логику от конкретной реализации хранения данных.
class GetGuestChatHistoryUseCase extends CoreFutureUseCase<String, List<ChatMessage>> {
  // Инициализация репозитория через сервис-локатор (sl), обеспечивая разделение зависимостей и удобство тестирования.
  GetGuestChatHistoryUseCase() : _repository = sl();

  // Репозиторий, который занимается операциями, связанными с гостевым чатом.
  final GuestChatRepository _repository;


  /// Выполнение use case.
  ///
  /// Параметр [param] используется для идентификации конкретной сессии чата или пользователя.
  /// Метод возвращает асинхронный Future, который содержит список сообщений чата [ChatMessage].
  ///
  /// Возвращает:
  ///   Future, который разрешается в список сообщений чата [ChatMessage].
  @override
  Future<List<ChatMessage>> execute(String param) async {
    // Вызов репозитория для получения истории чата.
    final result = await _repository.getGuestChatHistory(param);

    // Преобразование полученных данных (DTO) в список сущностей [ChatMessage].
    // Это преобразование помогает отделить бизнес-логику от слоя данных.
    return ChatMessage.fromDtoList(result);
  }
}
