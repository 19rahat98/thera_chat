import 'package:theta_chat/common/domain/abstract/core_use_case.dart';
import 'package:theta_chat/di/service_locator.dart';
import 'package:theta_chat/feature/auth/common/data/repository/authorized_repository.dart';
import 'package:theta_chat/feature/auth/common/data/repository/global_personal_secure_data_repository.dart';
import 'package:theta_chat/feature/auth/common/domain/entity/global_auth_reponse_entity.dart';

/// use case для авторизации
class GlobalSignInWithEmailUseCase extends CoreFutureUseCase<SignInEmailParam, void> {
  GlobalSignInWithEmailUseCase()
      : _repository = sl(),
        _personalSecureDataRepository = sl();

  final AuthRepository _repository;
  final GlobalPersonalSecureDataRepository _personalSecureDataRepository;

  @override
  Future<void> execute(SignInEmailParam param) async {
    final response = await _repository.singInWithEmail(param);

    ///сохранение данных
    saveUserDataToLocalStorage(response, param.email);
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

class SignInEmailParam {
  final String email;
  final String password;

  SignInEmailParam(this.email, this.password);

  Map<String, dynamic> toJson() => {
        'email': email,
        'password': password,
      };
}
