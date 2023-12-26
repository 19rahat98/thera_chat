import 'package:theta_chat/common/domain/abstract/core_use_case.dart';
import 'package:theta_chat/di/service_locator.dart';
import 'package:theta_chat/feature/chat/guest/domain/entity/chat_message_entity.dart';
import 'package:theta_chat/feature/chat/thera_chat/data/repository/thera_chat_repository.dart';

/// Use case для получения истории чата.
///
/// Этот use case отвечает за получение данных о предыдущих сообщениях в чате.
/// Для получения данных он использует [TheraChatRepository], который является абстракцией
/// слоя данных и позволяет изолировать бизнес-логику от конкретной реализации хранения данных.
class GetTheraChatHistoryUseCase extends CoreFutureNoneParamUseCase<List<ChatMessage>> {
  // Инициализация репозитория через сервис-локатор (sl), обеспечивая разделение зависимостей и удобство тестирования.
  GetTheraChatHistoryUseCase() : _repository = sl();

  // Репозиторий, который занимается операциями, связанными с Th3ra чатом.
  final TheraChatRepository _repository;

  /// Выполнение use case.
  ///
  /// Возвращает:
  ///   Future, который разрешается в список сообщений чата [ChatMessage].
  @override
  Future<List<ChatMessage>> execute() async {
    // Вызов репозитория для получения истории чата.
    final result = await _repository.getChatHistory();

    // Преобразование полученных данных (DTO) в список сущностей [ChatMessage].
    // Это преобразование помогает отделить бизнес-логику от слоя данных.
    return ChatMessage.fromDtoList(result);
  }
}
