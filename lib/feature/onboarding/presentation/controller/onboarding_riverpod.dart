import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:theta_chat/common/constants/app_core_constant.dart';
import 'package:theta_chat/common/exception/exception.dart';
import 'package:theta_chat/di/service_locator.dart';
import 'package:theta_chat/feature/chat/guest/domain/entity/chat_id_entity.dart';
import 'package:theta_chat/feature/chat/guest/domain/entity/chat_message_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:theta_chat/feature/chat/guest/domain/use_cases/sent_guest_message_use_case.dart';
import 'package:theta_chat/feature/chat/guest/domain/use_cases/start_guest_chat_use_case.dart';
import 'package:theta_chat/utils/mixins/request_worker_mixin.dart';

part 'onboarding_state.dart';

/// Использование провайдера для создания экземпляра контроллера ананимного чата.
final onboardingProvider = StateNotifierProvider.autoDispose<OnboardingController, OnboardingState>(
  (ref) => OnboardingController()..startChat(),
);

class OnboardingController extends StateNotifier<OnboardingState> with CoreRequestWorkedMixin {
  // Использование service locator для инъекции зависимости.
  OnboardingController()
      : _startGuestChat = sl(),
        _sendMessageAsGuest = sl(),
        super(
          OnboardingState.loading([
            ChatMessage.assistantMessage(),
          ]),
        );

  // Use case для начала новой сессии гостевого чата.
  final StartGuestChatUseCase _startGuestChat;

  // Use case для отправки сообщений как гость.
  final SendMessageAsGuestChatUseCase _sendMessageAsGuest;

  // Идентификатор текущего чата.
  String _chatId = CoreConstant.empty;

  // Список сообщений в чате.
  final List<ChatMessage> _chatMessages = [];

  /// Запускаем экран с анимации
  Future<void> startChat() async {
    await Future.delayed(
      const Duration(seconds: 2),
    );
    _chatMessages.add(
      ChatMessage.assistantMessage(
        text:
            'Приветствую тебя, умный и внимательный соучастник! Я рад видеть тебя здесь. Буду рад помочь в любых вопросах, связанных с психологией. Как вас зовут?',
      ),
    );
    state = OnboardingState.sendMessage(_chatMessages);
    await Future.delayed(
      const Duration(milliseconds: 1500),
    );
    _chatMessages.add(
      ChatMessage.userMessage('Привет, меня зовут Эмма.'),
    );
    state = OnboardingState.sendMessage(_chatMessages);
    await Future.delayed(
      const Duration(milliseconds: 1500),
    );
    _chatMessages.add(
      ChatMessage.assistantMessage(
          text:
              'Для начала можешь выбрать, зайти как постоянный пользователь, чтобы я мог запомнить твои предпочтения и продолжить наши беседы, или остаться анонимным гостем и получить помощь без сохранения информации. Какой вариант тебе ближе сейчас?'),
    );
    state = OnboardingState.finish(_chatMessages);
  }

  /// Начинает новую сессию гостевого чата.
  ///
  /// Запускает асинхронный запрос на создание нового чата.
  Future<void> startGuestChat() async {
    final request = _startGuestChat.execute();
    _chatMessages.add(
      ChatMessage.assistantMessage(),
    );
    state = OnboardingState.loading(_chatMessages);

    await launchWithError<ChatIdEntity, HttpRequestException>(
      request: request,
      loading: (isLoading) => state = state.copyWith(isLoading: isLoading),
      resultData: (result) {
        _chatId = result.chatId;
        _chatMessages.removeLast();
        _chatMessages.add(
          ChatMessage.assistantMessage(
            text:
                'Давайте познакомимся с доступными модулями. У меня есть несколько интересных инструментов, которые могут быть полезными. Хочешь ознакомится?',
          ),
        );
        state = OnboardingState.guestMessage(_chatMessages);
      },
      errorData: (exception, status) {
        state = OnboardingState.error(exception?.message ?? CoreConstant.error, _chatMessages);
      },
    );
  }

  /// Стартуем чат как гость
  Future<void> stayLikeGuest() async {
    await Future.delayed(
      const Duration(milliseconds: 1500),
    );
    _chatMessages.add(
      ChatMessage.additionalMessage('Вы выбрали остаться как гость'),
    );
    _chatMessages.add(
      ChatMessage.assistantMessage(
        text:
            'Понимаю, что для некоторых людей анонимность очень важна, особенно при обсуждении личных или чувствительных вопросов. Это нормально и абсолютно в порядке. Главное, чтобы ты чувствовал себя комфортно и свободно выражать свои мысли и чувства. Готов помочь и поддержать в любой ситуации, которая тебе беспокоит.',
      ),
    );
    state = OnboardingState.sendMessage(_chatMessages);
    await startGuestChat();
  }

  /// Отправляет новое сообщение в чат.
  ///
  /// [text] - текст сообщения для отправки.
  Future<void> sendNewMessage(String text) async {
    _chatMessages.addAll(
      [ChatMessage.userMessage(text), ChatMessage.assistantMessage()],
    );

    final request = _sendMessageAsGuest.execute(
      UserMessageParam(id: _chatId, message: text),
    );

    await launchWithError<ChatMessage, HttpRequestException>(
      request: request,
      loading: (isLoading) => state = state.copyWith(isLoading: isLoading, chat: _chatMessages),
      resultData: (result) {
        _chatMessages.replaceRange(_chatMessages.length - 1, _chatMessages.length, [result]);
        state = OnboardingState.guestMessage(_chatMessages);
      },
      errorData: (exception, status) {
        _chatMessages.removeLast();
        state = OnboardingState.error(
          exception?.message ?? CoreConstant.error,
          _chatMessages,
        );
      },
    );
  }
}
