import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:theta_chat/common/constants/app_core_constant.dart';
import 'package:theta_chat/common/exception/exception.dart';
import 'package:theta_chat/di/service_locator.dart';
import 'package:theta_chat/feature/auth/common/presentation/controller/authentication_controller.dart';
import 'package:theta_chat/feature/chat/guest/domain/entity/chat_message_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:theta_chat/feature/chat/thera_chat/domain/use_cases/get_thera_chat_history_use_case.dart';
import 'package:theta_chat/feature/chat/thera_chat/domain/use_cases/sent_message_to_thera_use_case.dart';
import 'package:theta_chat/utils/mixins/request_worker_mixin.dart';

part 'thera_chat_state.dart';

/// Использование провайдера для создания экземпляра контроллера ананимного чата.
final theraChatProvider = StateNotifierProvider.autoDispose<TheraChatController, TheraChatState>(
  (ref) => TheraChatController()..startChat(ref),
);

class TheraChatController extends StateNotifier<TheraChatState> with CoreRequestWorkedMixin {
  // Использование service locator для инъекции зависимости.
  TheraChatController()
      : _sendMessageToTheraChat = sl(),
        _getTheraChatHistoryUseCase = sl(),
        super(const TheraChatState.history());

  final SendMessageToTheraChatUseCase _sendMessageToTheraChat;
  final GetTheraChatHistoryUseCase _getTheraChatHistoryUseCase;

  List<ChatMessage> _chatMessages = [];

  Future<void> startChat(AutoDisposeStateNotifierProviderRef ref) async {
    final request = _getTheraChatHistoryUseCase.execute();
    state = const TheraChatState.loading();

    await launchWithError<List<ChatMessage>, HttpRequestException>(
      request: request,
      loading: (isLoading) => state = state.copyWith(isLoading: isLoading),
      resultData: (result) {
        if (result.isEmpty) {
          _chatMessages.addAll(ChatMessage.welcomeMessages());
        } else {
          _chatMessages = result;
          final user = ref.read(authProvider.notifier).state.user;
          _chatMessages.add(
            ChatMessage.additionalMessage('You logged in as ${user?.fillName}'),
          );
          _chatMessages.add(
            ChatMessage.assistantMessage(
              text:
                  "Hello ${user?.name}! I am glad to see you here again. It's great that you decided to log in using your account. \nThis will give us the opportunity to study your progress, preferences in more depth and better adapt the program to your needs. What questions have you had since our last conversation, or how can I help you now?",
            ),
          );
        }

        state = state.copyWith(chat: _chatMessages);
      },
      errorData: (exception, status) {
        state = TheraChatState.error(exception?.message ?? CoreConstant.error, _chatMessages);
      },
    );
  }

  Future<void> sendNewMessage(String text) async {
    _chatMessages.addAll(
      [ChatMessage.userMessage(text), ChatMessage.assistantMessage()],
    );

    final request = _sendMessageToTheraChat.execute(
      TheraMessageParam(message: text),
    );

    await launchWithError<ChatMessage, HttpRequestException>(
      request: request,
      loading: (isLoading) => state = state.copyWith(
          isWaitingAssistant: isLoading, chat: _chatMessages, status: TheraChatStatus.common),
      resultData: (result) {
        _chatMessages.replaceRange(_chatMessages.length - 1, _chatMessages.length, [result]);
        state = TheraChatState._(chat: _chatMessages);
      },
      errorData: (exception, status) {
        _chatMessages.removeLast();
        state = TheraChatState.error(
          exception?.message ?? CoreConstant.error,
          _chatMessages,
        );
      },
    );
  }
}
