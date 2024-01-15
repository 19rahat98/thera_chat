import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:theta_chat/common/constants/app_core_constant.dart';
import 'package:theta_chat/common/exception/auth_error_entity.dart';
import 'package:theta_chat/di/service_locator.dart';
import 'package:theta_chat/feature/auth/common/domain/entity/user_detail_entity.dart';
import 'package:theta_chat/feature/auth/common/domain/use_cases/updata_user_data_use_case.dart';
import 'package:theta_chat/utils/mixins/request_worker_mixin.dart';

part 'update_user_state.dart';

/// Использование провайдера для создания экземпляра контроллера входа в систему.
final updateUserProvider =
    StateNotifierProvider.autoDispose<UpdateUserDataController, UpdateUserState>(
  (ref) => UpdateUserDataController(),
);

class UpdateUserDataController extends StateNotifier<UpdateUserState> with CoreRequestWorkedMixin {
  // Использование service locator для инъекции зависимости.
  UpdateUserDataController()
      : _updateUserDataUseCase = sl(),
        super(const UpdateUserState());

  final GlobalUpdateUserDataUseCase _updateUserDataUseCase;

  late UserDetailEntity user;
  String _email = CoreConstant.empty;
  String _password = CoreConstant.empty;

  void initController(UserDetailEntity userData) {
    user = userData;
  }

  /// Метод для входа в систему с использованием электронной почты и пароля.
  Future<void> update(String email, String name, String surname) async {
    final request = _updateUserDataUseCase.execute(
      user.copyWith(email: email, name: name, surname: surname),
    );

    await launchWithAuthError<UserDetailEntity, GlobalAuthException>(
      request: request,
      loading: (isLoading) => state = UpdateUserState(isLoading: isLoading),
      resultData: (result) => state = UpdateUserState(
        status: UpdateUserStatus.success,
        user: result,
      ),
      errorData: (exception, status) {
        state = UpdateUserState(
          status: UpdateUserStatus.failure,
          errorMessage: exception?.errorMessage ?? CoreConstant.empty,
        );
      },
    );
  }

  @override
  void dispose() {
    _email = CoreConstant.empty;
    _password = CoreConstant.empty;
    super.dispose();
  }
}
