import 'package:theta_chat/common/domain/abstract/core_use_case.dart';
import 'package:theta_chat/di/service_locator.dart';
import 'package:theta_chat/feature/auth/common/data/repository/authorized_repository.dart';
import 'package:theta_chat/feature/auth/common/data/repository/global_personal_secure_data_repository.dart';
import 'package:theta_chat/feature/auth/common/domain/entity/global_auth_reponse_entity.dart';
import 'package:theta_chat/feature/auth/sign_up/domain/entity/sign_up_param.dart';

/// use case для авторизации
class GlobalSignUpWithEmailUseCase extends CoreFutureUseCase<SignUpEmailParam, void> {
  GlobalSignUpWithEmailUseCase()
      : _repository = sl(),
        _personalSecureDataRepository = sl();

  final AuthRepository _repository;
  final GlobalPersonalSecureDataRepository _personalSecureDataRepository;

  @override
  Future<void> execute(SignUpEmailParam param) async {
    final response = await _repository.singUpWithEmail(param);
    final result = GlobalAccessToken.fromDTO(response);

    ///сохранение данных
    saveUserDataToLocalStorage(result, param.email);
    return;
  }

  ///сохранение данных в sheared prefs
  void saveUserDataToLocalStorage(GlobalAccessToken response, String email) {
    _personalSecureDataRepository
      ..setEmailNumber(email)
      ..setAccessToken(response.access)
      ..setRefreshToken(response.refresh);
  }
}

