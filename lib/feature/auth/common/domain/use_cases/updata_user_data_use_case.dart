import 'package:theta_chat/common/domain/abstract/core_use_case.dart';
import 'package:theta_chat/di/service_locator.dart';
import 'package:theta_chat/feature/auth/common/data/repository/authorized_repository.dart';
import 'package:theta_chat/feature/auth/common/domain/entity/user_detail_entity.dart';

/// use case для получение данных юзера
class GlobalUpdateUserDataUseCase extends CoreFutureUseCase<UserDetailEntity, UserDetailEntity> {
  GlobalUpdateUserDataUseCase() : _repository = sl();

  final AuthRepository _repository;

  @override
  Future<UserDetailEntity> execute(UserDetailEntity param) async {
    final response = await _repository.updateUserData(
      param.toJson(),
    );
    return UserDetailEntity.fromDto(response);
  }
}
