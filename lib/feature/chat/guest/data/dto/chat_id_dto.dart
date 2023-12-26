class ChatIdDto {
  ChatIdDto({this.chatId});

  factory ChatIdDto.fromJson(Map<String, dynamic>? json) => ChatIdDto(
        chatId: json?['id'] as String?,
      );

  final String? chatId;
}
