import 'package:theta_chat/common/exception/exception.dart';

/// модель для ошибки при авторизации
class GlobalAuthException extends HttpRequestException<dynamic> {
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

  factory GlobalAuthException.fromJson(
    Map<String, dynamic> json,
  ) =>
      GlobalAuthException(
        json: json,
        statusCode: json['status_code'] as int? ?? 500,
        errorMessage: json['message'] as String?,
      );

  int? statusCode;
  String? errorMessage;
  String? fieldType;
  Map<String, dynamic>? json;

  GlobalAuthException? get email => GlobalAuthException.fromJson(
        json?['email'] as Map<String, dynamic>? ?? <String, dynamic>{},
      );

  GlobalAuthException? get password => GlobalAuthException.fromJson(
        json?['password'] as Map<String, dynamic>? ?? <String, dynamic>{},
      );

  GlobalAuthException? get error => GlobalAuthException.fromJson(
        json?['error'] as Map<String, dynamic>? ?? <String, dynamic>{},
      );
}
