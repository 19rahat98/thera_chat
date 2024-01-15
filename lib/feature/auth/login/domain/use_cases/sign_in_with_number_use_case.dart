import 'package:theta_chat/common/domain/abstract/core_use_case.dart';
import 'package:theta_chat/di/service_locator.dart';
import 'package:theta_chat/feature/auth/common/data/repository/authorized_repository.dart';
import 'package:theta_chat/feature/auth/common/data/repository/global_personal_secure_data_repository.dart';
import 'package:theta_chat/feature/auth/common/domain/entity/global_auth_reponse_entity.dart';

/// use case для авторизации
class GlobalSignInWithPhoneUseCase extends CoreFutureUseCase<SignInPhoneParam, void> {
  GlobalSignInWithPhoneUseCase()
      : _repository = sl(),
        _personalSecureDataRepository = sl();

  final AuthRepository _repository;
  final GlobalPersonalSecureDataRepository _personalSecureDataRepository;

  @override
  Future<void> execute(SignInPhoneParam param) async {
    final response = await _repository.singInWithPhone(param);
    final result = GlobalAccessToken.fromDTO(response);

    ///сохранение данных
    saveUserDataToLocalStorage(result, param.phone);
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

class SignInPhoneParam {
  final String phone;
  final String password;

  SignInPhoneParam(this.phone, this.password);

  Map<String, dynamic> toJson() => {
        'phone': phone,
        'password': password,
      };
}
