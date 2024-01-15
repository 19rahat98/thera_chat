import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:theta_chat/common/constants/app_core_constant.dart';
import 'package:theta_chat/common/exception/auth_error_entity.dart';
import 'package:theta_chat/di/service_locator.dart';
import 'package:theta_chat/feature/auth/login/domain/use_cases/sign_in_with_email_use_case.dart';
import 'package:theta_chat/feature/auth/login/domain/use_cases/sign_in_with_number_use_case.dart';
import 'package:theta_chat/utils/extentions/string_ext.dart';
import 'package:theta_chat/utils/mixins/request_worker_mixin.dart';

part 'sign_in_state.dart';

/// Использование провайдера для создания экземпляра контроллера входа в систему.
final signInProvider = StateNotifierProvider.autoDispose<SingInController, SignInState>(
  (ref) => SingInController(),
);

class SingInController extends StateNotifier<SignInState> with CoreRequestWorkedMixin {
  // Использование service locator для инъекции зависимости.
  SingInController()
      : _signInUseCase = sl(),
        _signInWithPhone = sl(),
        super(SignInCommonState());

  final GlobalSignInWithEmailUseCase _signInUseCase;
  final GlobalSignInWithPhoneUseCase _signInWithPhone;

  String _email = CoreConstant.empty;
  String _password = CoreConstant.empty;

  /// Метод для входа в систему с использованием электронной почты и пароля.
  Future<void> signInWithEmail(String login, String password) async {
    final state = _getCommonState();
    final request = login.isPhoneNumber()
        ? _signInWithPhone.execute(SignInPhoneParam(login, password))
        : _signInUseCase.execute(SignInEmailParam(login, password));

    await launchWithAuthError<void, GlobalAuthException>(
      request: request,
      loading: (isLoading) => this.state = state.copyWith(isLoading: isLoading),
      resultData: (result) => this.state = SuccessSignInState(),
      errorData: (exception, status) {
        if (exception?.password != null) {
          this.state = state.copyWith(
            isButtonIsEnable: false,
            errorPassword: exception?.password?.errorMessage,
          );
        } else {
          this.state = FailureSignInState(errorMessage: exception?.errorMessage);
        }
      },
    );
  }

  /// Метод для инициализации входа в систему.
  void launchSignIn() => signInWithEmail(_email, _password);

  /// Методы для установки email и пароля, а также для сброса ошибок.
  void setEmail(String email) {
    _email = email;
    _resetErrorIfNeeded();
  }

  void setPassword(String password) {
    _password = password;
    _resetErrorIfNeeded();
  }

  /// Минимальная волидация
  /// Проверяем, пустые ли поля эмейл и пароль
  bool _validateFields() {
    if (_email.isEmpty || _password.isEmpty) {
      return false;
    }
    return true;
  }

  /// Логика для получения текущего общего состояния входа.
  SignInCommonState _getCommonState() {
    return state is SignInCommonState ? state as SignInCommonState : SignInCommonState();
  }

  /// Вспомогательный метод для сброса ошибок при изменении данных входа.
  void _resetErrorIfNeeded() {
    final commonState = _getCommonState();
    if (commonState.errorPassword?.isNotEmpty == true) {
      state = commonState.copyWith(errorPassword: null);
    }
    state = commonState.copyWith(isButtonIsEnable: _validateFields());
  }

  @override
  void dispose() {
    _email = CoreConstant.empty;
    _password = CoreConstant.empty;
    super.dispose();
  }
}
