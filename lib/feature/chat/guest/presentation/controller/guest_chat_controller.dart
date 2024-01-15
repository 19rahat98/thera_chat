import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:theta_chat/common/constants/app_core_constant.dart';
import 'package:theta_chat/common/exception/exception.dart';
import 'package:theta_chat/di/service_locator.dart';
import 'package:theta_chat/feature/chat/guest/domain/entity/chat_id_entity.dart';
import 'package:theta_chat/feature/chat/guest/domain/entity/chat_message_entity.dart';
import 'package:theta_chat/feature/chat/guest/domain/use_cases/sent_guest_message_use_case.dart';
import 'package:theta_chat/feature/chat/guest/domain/use_cases/start_guest_chat_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:theta_chat/utils/mixins/request_worker_mixin.dart';

part 'guest_chat_state.dart';

/// Использование провайдера для создания экземпляра контроллера ананимного чата.
final guestChatProvider = StateNotifierProvider.autoDispose<GuestChatController, GuestChatState>(
  (ref) => GuestChatController(),
);

class GuestChatController extends StateNotifier<GuestChatState> with CoreRequestWorkedMixin {
  // Использование service locator для инъекции зависимости.
  GuestChatController()
      : _startGuestChat = sl(),
        _sendMessageAsGuest = sl(),
        super(GuestChatState.onboarding());

// Use case для начала новой сессии гостевого чата.
  final StartGuestChatUseCase _startGuestChat;

  // Use case для отправки сообщений как гость.
  final SendMessageAsGuestChatUseCase _sendMessageAsGuest;

  // Идентификатор текущего чата.
  String _chatId = CoreConstant.empty;

  // Список сообщений в чате.
  List<ChatMessage> _chatMessages = [];

  /// Начинает новую сессию гостевого чата.
  ///
  /// Запускает асинхронный запрос на создание нового чата.
  Future<void> startGuestChat() async {
    final request = _startGuestChat.execute();
    state = const GuestChatState.loading();

    await launchWithError<ChatIdEntity, HttpRequestException>(
      request: request,
      loading: (isLoading) => state = state.copyWith(isLoading: isLoading),
      resultData: (result) {
        _chatId = result.chatId;
      },
      errorData: (exception, status) {
        state = GuestChatState.error(exception?.message ?? CoreConstant.error, _chatMessages);
      },
    );
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
      loading: (isLoading) =>
          state = state.copyWith(isWaitingAssistant: isLoading, chat: _chatMessages),
      resultData: (result) {
        _chatMessages.replaceRange(_chatMessages.length - 1, _chatMessages.length, [result]);
        state = GuestChatState._(chat: _chatMessages);
      },
      errorData: (exception, status) {
        _chatMessages.removeLast();
        state = GuestChatState.error(
          exception?.message ?? CoreConstant.error,
          _chatMessages,
        );
      },
    );
  }
}
