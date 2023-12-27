part of 'thera_chat_controller.dart';

/// Перечисление состояний чата.
enum TheraChatStatus {
  common, // Обычное состояние.
  failure, // Состояние ошибки.
  history, // Состояние ожидания (например, начальной загрузки).
}

/// Класс состояния для управления состоянием чата.
///
/// Этот класс расширяет [Equatable] для эффективного сравнения состояний.
class TheraChatState extends Equatable {
  const TheraChatState._({
    this.errorMessage,
    this.chat = const [],
    this.isLoading = false,
    this.isWaitingAssistant = false,
    this.status = TheraChatStatus.common,
  });

  /// Создает состояние для онбординга.
  const TheraChatState.history()
      : this._(status: TheraChatStatus.history, isWaitingAssistant: true);

  /// Создает состояние загрузки.
  const TheraChatState.loading() : this._(status: TheraChatStatus.common, isLoading: true);

  /// Создает состояние с ошибкой.
  const TheraChatState.error(String message, List<ChatMessage> chat)
      : this._(
    chat: chat,
    errorMessage: message,
    isWaitingAssistant: false,
    status: TheraChatStatus.failure,
  );

  /// Флаг, указывающий, идет ли загрузка.
  final bool isLoading;

  /// Сообщение об ошибке (если есть).
  final String? errorMessage;

  /// Текущее состояние чата.
  final TheraChatStatus status;

  /// Флаг, указывающий, ожидается ли ответ от ассистента.
  final bool isWaitingAssistant;

  /// Список текстов сообщений междуй ассистентом и юзером
  final List<ChatMessage> chat;

  bool get enableChat => !isWaitingAssistant & !isLoading;

  @override
  List<Object> get props => [isLoading, isWaitingAssistant, status, errorMessage ?? 0, chat];

  /// Метод `copyWith` для изменения части данных состояния.
  ///
  /// Позволяет изменить определенные поля состояния, сохраняя неизменными остальные.
  TheraChatState copyWith({
    bool? isLoading,
    List<ChatMessage>? chat,
    TheraChatStatus? status,
    bool? isWaitingAssistant,
  }) {
    return TheraChatState._(
      errorMessage: null,
      chat: chat ?? this.chat,
      status: status ?? this.status,
      isLoading: isLoading ?? this.isLoading,
      isWaitingAssistant: isWaitingAssistant ?? this.isWaitingAssistant,
    );
  }
}
