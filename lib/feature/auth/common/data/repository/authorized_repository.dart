import 'package:theta_chat/common/constants/app_global_constants.dart';
import 'package:theta_chat/common/network/authorized_api_service.dart';
import 'package:theta_chat/common/network/unauthorized_api_service.dart';
import 'package:theta_chat/di/service_locator.dart';
import 'package:theta_chat/feature/auth/common/data/dto/global_auth_response_dto.dart';
import 'package:theta_chat/feature/auth/common/data/local/global_personal_secure_data_source.dart';
import 'package:theta_chat/feature/auth/common/domain/entity/global_auth_reponse_entity.dart';
import 'package:theta_chat/feature/auth/login/domain/use_cases/sign_in_with_email_use_case.dart';
import 'package:theta_chat/utils/http_call_utils.dart';

/// Класс AuthRepository обрабатывает различные запросы,
/// связанные с аутентификацией и управлением учетными данными пользователя.
class AuthRepository {
  AuthRepository()
      : _apiService = sl(),
        _authorizedApiService = sl(),
        _dataSource = sl();

  /// Частные поля для API сервисов и источника данных.
  final UnauthorizedApiService _apiService;
  final AuthorizedApiService _authorizedApiService;
  final GlobalPersonalSecureDataSource _dataSource;

  /// обновление токена
  Future<GlobalAccessToken> refreshToken() async {
    final refreshTokenValue = await _dataSource.refreshToken;
    return safeApiCall<GlobalAccessToken>(
      _apiService.refreshToken(
        refreshTokenValue ?? AppGlobalConstants.emptyString,
      ),
      (Map<String, dynamic> json) {
        return GlobalAccessToken.fromDTO(GlobalAccessDTO.fromJson(json));
      },
      isTest: true,
    );
  }

  ///
  Future<void> signOut() async {}

  /// Логинется с помощью эмейла
  Future<GlobalAccessToken> singInWithEmail(SignInEmailParam param) async {
    return safeApiCall<GlobalAccessToken>(
      _apiService.signInWithEmail(param.toJson()),
      (Map<String, dynamic> json) {
        return GlobalAccessToken.fromDTO(GlobalAccessDTO.fromJson(json));
      },
    );
  }
}
