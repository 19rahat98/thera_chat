class ChatMessageDto {
  ChatMessageDto({
    this.role,
    this.text,
  });

  final String? role;
  final String? text;

  /// Factory method to create a ChatMessageDto from a JSON map.
  factory ChatMessageDto.fromJson(Map<String, dynamic> json) {
    return ChatMessageDto(
      role: json['role'] as String?,
      text: json['text'] as String?,
    );
  }

  /// Статичный метод чтобы парсит список сообщении с чата
  static List<ChatMessageDto> fromJsonList(List<dynamic>? jsonList) {
    final listOperations = <ChatMessageDto>[];
    if (jsonList != null) {
      for (final value in jsonList) {
        final valueMap = value as Map<String, dynamic>;
        listOperations.add(
          ChatMessageDto.fromJson(valueMap),
        );
      }
    }
    return listOperations;
  }

  /// Method to convert ChatMessageDto instance to a JSON map.
  Map<String, dynamic> toJson() {
    return {'role': role, 'text': text};
  }
}
