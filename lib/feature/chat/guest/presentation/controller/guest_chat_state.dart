part of 'guest_chat_controller.dart';

/// Перечисление состояний гостевого чата.
enum GuestChatStatus {
  common, // Обычное состояние.
  failure, // Состояние ошибки.
  onboarding, // Состояние ожидания (например, начальной загрузки).
}

/// Класс состояния для управления состоянием гостевого чата.
///
/// Этот класс расширяет [Equatable] для эффективного сравнения состояний.
class GuestChatState extends Equatable {
  const GuestChatState._({
    this.errorMessage,
    this.chat = const [],
    this.isLoading = false,
    this.isWaitingAssistant = false,
    this.status = GuestChatStatus.common,
  });

  /// Создает состояние для онбординга.
  GuestChatState.onboarding()
      : this._(status: GuestChatStatus.onboarding, chat: _chatting, isWaitingAssistant: true);

  /// Создает состояние загрузки.
  const GuestChatState.loading() : this._(status: GuestChatStatus.common, isLoading: true);

  /// Создает состояние с ошибкой.
  const GuestChatState.error(String message, List<ChatMessage> chat)
      : this._(
          chat: chat,
          errorMessage: message,
          isWaitingAssistant: false,
          status: GuestChatStatus.failure,
        );

  /// Флаг, указывающий, идет ли загрузка.
  final bool isLoading;

  /// Сообщение об ошибке (если есть).
  final String? errorMessage;

  /// Текущее состояние чата.
  final GuestChatStatus status;

  /// Флаг, указывающий, ожидается ли ответ от ассистента.
  final bool isWaitingAssistant;

  /// Список текстов сообщений междуй ассистентом и юзером
  final List<ChatMessage> chat;

  @override
  List<Object> get props => [isLoading, isWaitingAssistant, status, errorMessage ?? 0, chat];

  /// Метод `copyWith` для изменения части данных состояния.
  ///
  /// Позволяет изменить определенные поля состояния, сохраняя неизменными остальные.
  GuestChatState copyWith({
    bool? isLoading,
    List<ChatMessage>? chat,
    GuestChatStatus? status,
    bool? isWaitingAssistant,
  }) {
    return GuestChatState._(
      chat: chat ?? this.chat,
      status: status ?? this.status,
      isLoading: isLoading ?? this.isLoading,
      isWaitingAssistant: isWaitingAssistant ?? this.isWaitingAssistant,
    );
  }
}

final _chatting = [
  ChatMessage(
    role: 'assistant',
    message:
        'Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit. Exercitation venia consequat sunt nostrud amet.cccc',
  ),
  ChatMessage(
    role: 'user',
    message: 'Привет, меня зовут Эмма.',
  ),
  ChatMessage(
    role: 'assistant',
    message:
        'Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit. Exercitation venia consequat sunt nostrud amet.cccc',
  ),
  ChatMessage(
    role: 'user',
    message: 'Привет, меня зовут Эмма.',
  ),
  ChatMessage(
    role: 'assistant',
    message:
        'Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit. Exercitation venia consequat sunt nostrud amet.cccc',
  ),
  ChatMessage(
    role: 'user',
    message: 'Привет, меня зовут Эмма.',
  ),
  ChatMessage(
    role: 'assistant',
    message:
        'Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit. Exercitation venia consequat sunt nostrud amet.cccc',
  ),
];
