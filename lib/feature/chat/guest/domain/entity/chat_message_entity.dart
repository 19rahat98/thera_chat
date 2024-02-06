import 'package:theta_chat/common/constants/app_core_constant.dart';
import 'package:theta_chat/feature/chat/guest/data/dto/chat_message_dto.dart';

class ChatMessage {
  ChatMessage({
    required this.role,
    required this.message,
  });

  final String role;
  final String message;

  /// Factory method to create a ChatMessage entity from a ChatMessageDto.
  factory ChatMessage.fromDto(ChatMessageDto dto) {
    return ChatMessage(
      role: dto.role ?? CoreConstant.empty,
      message: dto.text ?? CoreConstant.empty,
    );
  }

  /// Создаем пустой мэсейдж для ассистента
  factory ChatMessage.assistantMessage({String? text}) => ChatMessage(
        role: 'assistant',
        message: text ?? CoreConstant.empty,
      );

  /// Создает экземпял обьекта для сообщений юзера
  factory ChatMessage.userMessage(String text) => ChatMessage(
        role: 'user',
        message: text,
      );

  /// Создает экземпял обьекта для сообщений event
  factory ChatMessage.additionalMessage(String text) => ChatMessage(
        role: 'additional',
        message: text,
      );

  static List<ChatMessage> fromDtoList(List<ChatMessageDto>? dtoList) {
    return dtoList?.map(ChatMessage.fromDto).toList() ?? [];
  }

  /// шаблонные сообщение
  static List<ChatMessage> welcomeMessages({String? userName}) => [
        ChatMessage.assistantMessage(
            text:
                "Greetings, smart and attentive partner! I'm glad to see you here. I will be glad to help with any questions related to psychology. What is your name?"),
        ChatMessage.userMessage('Hello, My name is ${userName ?? 'Emma'}'),
        ChatMessage.assistantMessage(
            text:
                "To begin with, you can choose to log in as a regular user so that I can remember your preferences and continue our conversations, or remain an anonymous guest and get help without saving information. Which option is closer to you now?"),
        ChatMessage.additionalMessage('You have successfully completed the registration'),
        ChatMessage.assistantMessage(
            text:
                "Congratulations on completing the registration! This is a wonderful step to begin the path to self-knowledge and personal development. \nNow we have the opportunity to work deeper and more individually on your requests and goals. What brings you here today? Is there anything in particular that you would like to work on or talk about?"),
      ];

  /// Проверка, чея это сообщение
  bool get isAssistantMessage => role == 'assistant';

  bool get isAdditionalMessage => role == 'additional';
}
