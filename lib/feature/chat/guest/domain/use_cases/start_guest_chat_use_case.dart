import 'package:theta_chat/common/domain/abstract/core_use_case.dart';
import 'package:theta_chat/di/service_locator.dart';
import 'package:theta_chat/feature/chat/guest/data/repository/guest_chat_repository.dart';
import 'package:theta_chat/feature/chat/guest/domain/entity/chat_id_entity.dart';

/// Представляет вариант использования для начала новой сессии гостевого чата.
///
/// Этот use case абстрагирует логику инициирования сессии чата для гостевого пользователя.
/// Он делегирует реальные операции по получению и обработке данных репозиторию [GuestChatRepository].
class StartGuestChatUseCase extends CoreFutureNoneParamUseCase<ChatIdEntity> {
  // Конструктор инициализирует репозиторий.
  // Репозиторий получается из сервис-локатора (sl), что обеспечивает разделение и удобство тестирования.
  StartGuestChatUseCase() : _repository = sl();

  // Репозиторий, ответственный за операции с данными, связанными с гостевым чатом.
  // Этот репозиторий абстрагирует слой данных, предоставляя чистый интерфейс для use case.
  final GuestChatRepository _repository;

  @override

  /// Выполнение варианта использования.
  ///
  /// Этот метод инициирует начало новой сессии гостевого чата, вызывая репозиторий.
  /// Затем он преобразует полученные от репозитория данные (DTO) в сущность домена (ChatIdEntity).
  ///
  /// Возвращает:
  ///   Future, который разрешается в [ChatIdEntity], представляющий начатую сессию чата.
  Future<ChatIdEntity> execute() async {
    // Вызов репозитория для начала новой сессии гостевого чата.
    final result = await _repository.startNewGuestChat();

    // Преобразование объекта передачи данных (DTO) в сущность домена.
    // Это преобразование изолирует слой домена от изменений в слое данных.
    return ChatIdEntity.fromDto(result);
  }
}
