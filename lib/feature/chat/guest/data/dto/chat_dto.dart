class ChatDto {
  ChatDto({
    this.text,
  });

  final String? text;

  /// Factory method to create a ChatMessageDto from a JSON map.
  factory ChatDto.fromJson(Map<String, dynamic> json) {
    return ChatDto(
      text: json['text'] as String?,
    );
  }

  /// Method to convert ChatMessageDto instance to a JSON map.
  Map<String, dynamic> toJson() {
    return {'text': text};
  }
}
