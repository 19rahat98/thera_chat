part of 'onboarding_riverpod.dart';

/// Перечисление состояний онбординга.
enum OnboardingStatus {
  common, // Обычное состояние.
  definitive, // Состояние когда завершается анимация.
  guestChat,
  failure,
}

/// Класс состояния для управления состоянием анимационного чата онбординга.
///
/// Этот класс расширяет [Equatable] для эффективного сравнения состояний.
class OnboardingState extends Equatable {
  const OnboardingState._({
    this.errorMessage,
    this.chat = const [],
    this.isLoading = false,
    this.status = OnboardingStatus.common,
  });

  /// Создает состояние для онбординга.
  const OnboardingState.finish(List<ChatMessage> chat)
      : this._(status: OnboardingStatus.definitive, chat: chat, isLoading: false);

  /// Создает состояние при анимации.
  const OnboardingState.sendMessage(List<ChatMessage> chat)
      : this._(status: OnboardingStatus.common, chat: chat, isLoading: false);

  /// Создает состояние при анимации.
  const OnboardingState.guestMessage(List<ChatMessage> chat)
      : this._(status: OnboardingStatus.guestChat, chat: chat, isLoading: false);

  /// Создает состояние загрузки.
  const OnboardingState.loading(List<ChatMessage> chat)
      : this._(status: OnboardingStatus.common, isLoading: true, chat: chat);

  /// Создает состояние с ошибкой.
  const OnboardingState.error(String message, List<ChatMessage> chat)
      : this._(
          chat: chat,
          errorMessage: message,
          status: OnboardingStatus.failure,
        );

  /// Флаг, указывающий, идет ли загрузка.
  final bool isLoading;

  /// Текущее состояние чата.
  final OnboardingStatus status;

  /// Список текстов сообщений междуй ассистентом и юзером
  final List<ChatMessage> chat;

  /// Сообщение об ошибке (если есть).
  final String? errorMessage;

  @override
  List<Object> get props => [isLoading, status, chat, errorMessage ?? 0];

  /// Метод `copyWith` для изменения части данных состояния.
  ///
  /// Позволяет изменить определенные поля состояния, сохраняя неизменными остальные.
  OnboardingState copyWith({
    bool? isLoading,
    List<ChatMessage>? chat,
    OnboardingStatus? status,
  }) {
    return OnboardingState._(
      chat: chat ?? this.chat,
      status: status ?? this.status,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
