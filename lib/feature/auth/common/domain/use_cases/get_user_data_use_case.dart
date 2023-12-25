import 'package:theta_chat/common/domain/abstract/core_use_case.dart';
import 'package:theta_chat/di/service_locator.dart';
import 'package:theta_chat/feature/auth/common/data/repository/authorized_repository.dart';
import 'package:theta_chat/feature/auth/common/domain/entity/user_detail_entity.dart';

/// use case для получение данных юзера
class GlobalGetUserDataUseCase extends CoreFutureNoneParamUseCase<void> {
  GlobalGetUserDataUseCase() : _repository = sl();

  final AuthRepository _repository;

  @override
  Future<UserDetailEntity> execute() async {
    final response = await _repository.userData();
    return UserDetailEntity.fromDto(response);
  }
}
