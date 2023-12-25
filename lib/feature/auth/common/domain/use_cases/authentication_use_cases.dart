import 'package:theta_chat/common/domain/abstract/core_use_case.dart';
import 'package:theta_chat/di/service_locator.dart';
import 'package:theta_chat/feature/auth/common/data/repository/global_personal_secure_data_repository.dart';

class CheckUserAccessUseCase extends CoreFutureNoneParamUseCase<void> {
  CheckUserAccessUseCase() : _personalSecureDataRepository = sl();

  final GlobalPersonalSecureDataRepository _personalSecureDataRepository;

  @override
  Future<GlobalUserDataEntity> execute() async {
    final userEmail = await _personalSecureDataRepository.userEmail;
    final accessToken = await _personalSecureDataRepository.accessToken;

    return GlobalUserDataEntity(
      accessToken: accessToken,
      userEmail: userEmail,
    );
  }
}

class GlobalUserDataEntity {
  GlobalUserDataEntity({
    this.accessToken,
    this.userEmail,
  });

  final String? userEmail;
  final String? accessToken;

  bool get isHaveAccessToken => accessToken?.isNotEmpty == true;
}
