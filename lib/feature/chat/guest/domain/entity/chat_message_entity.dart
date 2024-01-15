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
  static List<ChatMessage> welcomeMessages() => [
    ChatMessage.assistantMessage(text: 'Приветствую тебя, умный и внимательный соучастник! Я рад видеть тебя здесь. Буду рад помочь в любых вопросах, связанных с психологией. Как вас зовут?'),
    ChatMessage.userMessage('Привет, меня зовут Эмма.'),
    ChatMessage.assistantMessage(text: 'Для начала можешь выбрать, зайти как постоянный пользователь, чтобы я мог запомнить твои предпочтения и продолжить наши беседы, или остаться анонимным гостем и получить помощь без сохранения информации. Какой вариант тебе ближе сейчас?'),
    ChatMessage.additionalMessage('Вы успешно завершили регистрацию'),
    ChatMessage.assistantMessage(text: 'Поздравляю с завершением регистрации! Это замечательный шаг для того, чтобы начать путь к самопознанию и личному развитию. Теперь у нас есть возможность глубже и более индивидуально работать над вашими запросами и целями. Что вас привело сюда сегодня? Есть ли что-то конкретное, над чем вы хотели бы поработать или поговорить?'),
  ];

  /// Проверка, чея это сообщение
  bool get isAssistantMessage => role == 'assistant';

  bool get isAdditionalMessage => role == 'additional';
}
