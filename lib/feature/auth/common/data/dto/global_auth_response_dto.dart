import 'package:theta_chat/common/constants/app_core_constant.dart';

/// ответ для авторизации
class GlobalAuthResponseTokenDTO {
  GlobalAuthResponseTokenDTO({this.access, this.refresh});

  factory GlobalAuthResponseTokenDTO.fromJson(Map<String, dynamic> json) =>
      GlobalAuthResponseTokenDTO(
        access: json['access'] as String?,
        refresh: json['refresh'] as String?,
      );

  final String? access;
  final String? refresh;
}

/// ответ для авторизации
class GlobalAuthResponseDTO {
  GlobalAuthResponseDTO({
    this.email,
    this.tokens,
    this.phoneVerified,
    this.emailVerified,
  });

  factory GlobalAuthResponseDTO.fromJson(Map<String, dynamic> json) => GlobalAuthResponseDTO(
        email: json['email'] as String?,
        emailVerified: json['email_verified'] as bool? ?? false,
        phoneVerified: json['phone_verified'] as bool? ?? false,
        tokens: GlobalAuthResponseTokenDTO.fromJson(
          json['tokens'] as Map<String, dynamic>,
        ),
      );

  final String? email;
  final bool? emailVerified;
  final bool? phoneVerified;
  final GlobalAuthResponseTokenDTO? tokens;
}

/// ответ для регистарции
class GlobalRegistrationResponseDTO {
  GlobalRegistrationResponseDTO({
    this.data,
    this.email,
    this.phoneNumber,
    this.id = CoreConstant.empty,
  });

  factory GlobalRegistrationResponseDTO.fromJson(Map<String, dynamic> json) {
    final dataValue = GlobalResponseDTO.fromJson(json);
    return GlobalRegistrationResponseDTO(
      email: json['email'] as String?,
      id: dataValue.data['account_id'] as String,
      phoneNumber: json['phone_number'] as String?,
    );
  }

  String id;
  String? email;
  String? phoneNumber;
  GlobalResponseDTO? data;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    return data;
  }
}

/// ответ с сервера с [data]
class GlobalResponseDTO {
  GlobalResponseDTO({required this.data});

  factory GlobalResponseDTO.fromJson(Map<String, dynamic> json) => GlobalResponseDTO(
        data: json['data'] as Map<String, dynamic>,
      );

  final Map<String, dynamic> data;
}

/// ответ с сервера с [access]
class GlobalAccessDTO {
  GlobalAccessDTO({
    this.access,
    this.refresh,
  });

  factory GlobalAccessDTO.fromJson(Map<String, dynamic> json) => GlobalAccessDTO(
        access: json['access'] as String?,
        refresh: json['refresh'] as String?,
      );

  final String? access;
  final String? refresh;
}
