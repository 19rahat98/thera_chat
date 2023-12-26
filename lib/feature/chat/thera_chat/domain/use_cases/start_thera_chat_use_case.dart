import 'package:theta_chat/common/domain/abstract/core_use_case.dart';
import 'package:theta_chat/di/service_locator.dart';
import 'package:theta_chat/feature/chat/guest/domain/entity/chat_id_entity.dart';
import 'package:theta_chat/feature/chat/thera_chat/data/repository/thera_chat_repository.dart';

/// Представляет вариант использования для начала новой сессии чата.
///
/// Этот use case абстрагирует логику инициирования сессии чата для пользователя.
/// Он делегирует реальные операции по получению и обработке данных репозиторию [TheraChatRepository].
class StartNewTheraChatUseCase extends CoreFutureNoneParamUseCase<ChatIdEntity> {
  // Конструктор инициализирует репозиторий.
  // Репозиторий получается из сервис-локатора (sl), что обеспечивает разделение и удобство тестирования.
  StartNewTheraChatUseCase() : _repository = sl();

  // Репозиторий, ответственный за операции с данными, связанными с Thera чатом.
  final TheraChatRepository _repository;

  @override

  /// Выполнение варианта использования.
  ///
  /// Этот метод инициирует начало новой сессии Th3ra чата, вызывая репозиторий.
  /// Затем он преобразует полученные от репозитория данные (DTO) в сущность домена (ChatIdEntity).
  ///
  /// Возвращает:
  ///   Future, который разрешается в [ChatIdEntity], представляющий начатую сессию чата.
  Future<ChatIdEntity> execute() async {
    // Вызов репозитория для начала новой сессии чата.
    final result = await _repository.startNewtChat();

    // Преобразование объекта передачи данных (DTO) в сущность домена.
    // Это преобразование изолирует слой домена от изменений в слое данных.
    return ChatIdEntity.fromDto(result);
  }
}
