import 'package:theta_chat/common/constants/app_core_constant.dart';
import 'package:theta_chat/feature/auth/common/data/dto/global_auth_response_dto.dart';

/// ответ для авторизации
class GlobalAuthResponse {
  GlobalAuthResponse({
    this.tokens,
    this.phoneVerified,
    this.emailVerified,
    required this.email,
  });

  factory GlobalAuthResponse.fromDTO(GlobalAuthResponseDTO dto) => GlobalAuthResponse(
        email: dto.email ?? CoreConstant.empty,
        phoneVerified: dto.phoneVerified,
        emailVerified: dto.emailVerified,
        tokens: dto.tokens,
      );

  final String email;
  final bool? phoneVerified;
  final bool? emailVerified;
  final GlobalAuthResponseTokenDTO? tokens;
}

class GlobalAccessToken {
  GlobalAccessToken({
    this.access = CoreConstant.empty,
    this.refresh = CoreConstant.empty,
  });

  factory GlobalAccessToken.fromDTO(GlobalAccessDTO dto) => GlobalAccessToken(
        access: dto.access ?? CoreConstant.empty,
        refresh: dto.refresh ?? CoreConstant.empty,
      );

  final String access;
  final String refresh;
}
