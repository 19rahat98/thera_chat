import 'package:theta_chat/common/exception/exception.dart';

/// модель для ошибки при регистрации
class RegistrationException extends HttpRequestException<RegistrationException> {
  RegistrationException({
    required this.statusCode,
    this.errorMessage,
    this.fieldType,
    this.json,
    HttpTypeError httpTypeError = HttpTypeError.http,
  }) : super(
          code: statusCode,
          message: errorMessage,
          field: fieldType,
          httpTypeError: httpTypeError,
        );

  factory RegistrationException.fromJson(
    Map<String, dynamic> json,
  ) =>
      RegistrationException(
        json: json,
        statusCode: json['status_code'] as int? ?? 500,
        errorMessage: json['message'] as String?,
        fieldType: json['field'] as String?,
      );

  int statusCode;
  String? errorMessage;
  String? fieldType;
  Map<String, dynamic>? json;

  RegistrationException? get email => RegistrationException.fromJson(
        json?['email'] as Map<String, dynamic>? ?? <String, dynamic>{},
      );

  RegistrationException? get password => RegistrationException.fromJson(
        json?['password'] as Map<String, dynamic>? ?? <String, dynamic>{},
      );

  RegistrationException? get phoneNumber => RegistrationException.fromJson(
        json?['phone_number'] as Map<String, dynamic>? ?? <String, dynamic>{},
      );
}
