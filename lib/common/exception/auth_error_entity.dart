import 'package:theta_chat/common/exception/exception.dart';

/// модель для ошибки при авторизации
class GlobalAuthException<T> extends HttpRequestException<T> {
  GlobalAuthException({
    this.json,
    this.statusCode,
    this.errorMessage,
    this.fieldType,
    HttpTypeError httpTypeError = HttpTypeError.http,
  }) : super(
          code: statusCode ?? 500,
          message: errorMessage,
          field: fieldType,
          httpTypeError: httpTypeError,
        );

  factory GlobalAuthException.fromJson(Map<String, dynamic> json) => GlobalAuthException(
        json: json,
        statusCode: json['status_code'] as int? ?? 500,
        errorMessage: json['message'] as String?,
      );

  int? statusCode;
  String? errorMessage;
  String? fieldType;
  Map<String, dynamic>? json;

  /// Общий метод для получения ошибок
  GlobalAuthException? _getError(String key) {
    if (json?[key] != null) {
      return GlobalAuthException.fromJson(
        json?[key] as Map<String, dynamic>? ?? <String, dynamic>{},
      );
    }
    return null;
  }

  /// Получение ошибки email
  GlobalAuthException? get email => _getError('email');

  /// Получение ошибки password
  GlobalAuthException? get password => _getError('password');

  /// Получение общей ошибки
  GlobalAuthException? get error => _getError('error');
}
