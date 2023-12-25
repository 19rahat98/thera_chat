/// модель получения ошибок по умолчанию
class DefaultError {
  String message;

  DefaultError(this.message);

  factory DefaultError.fromJson(Map<String, dynamic> map) {
    if (map['message'] != null) {
      return DefaultError(map['message']);
    } else if (map['error'] != null) {
      return DefaultError(map['error']);
    } else if (map['detail'] != null) {
      return DefaultError(map['detail']);
    } else if (map['data'] != null) {
      return DefaultError(map['data']);
    } else if (map['errors']['message'] != null) {
      return DefaultError(map['errors']['message']);
    } else if (map['error']['message'] != null) {
      return DefaultError(map['errors']['message']);
    }
    return DefaultError("Ошибка сервера");
  }
}
