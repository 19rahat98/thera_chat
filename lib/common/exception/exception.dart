/// базовая обработка http ошибок
/// [message] тело ошибки
/// [code] http код ошибки
class HttpRequestException<T> implements Exception {
  int code;
  String? message;
  String? field;
  HttpTypeError? httpTypeError;

  factory HttpRequestException.fromJson(
    Map<String, dynamic> json,
  ) =>
      HttpRequestException(
        code: json['status_code'] as int,
        message: json['message'] as String?,
        field: json['details'] as String?,
      );

  HttpRequestException({
    required this.code,
    this.message,
    this.field,
    this.httpTypeError,
  });
}

enum HttpTypeError {
  unknown,
  notInternetConnection,
  http,
}
