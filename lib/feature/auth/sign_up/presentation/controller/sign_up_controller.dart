import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:theta_chat/common/constants/app_core_constant.dart';
import 'package:theta_chat/common/exception/auth_error_entity.dart';
import 'package:theta_chat/di/service_locator.dart';
import 'package:theta_chat/feature/auth/sign_up/domain/entity/sign_up_param.dart';
import 'package:theta_chat/feature/auth/sign_up/domain/entity/validation_password_entity.dart';
import 'package:theta_chat/feature/auth/sign_up/domain/use_cases/sign_up_with_email_use_case.dart';
import 'package:theta_chat/utils/mixins/request_worker_mixin.dart';

part 'sign_up_state.dart';

/// Использование провайдера для создания экземпляра контроллера входа в систему.
final signUpProvider = StateNotifierProvider.autoDispose<SingUpController, SignUpState>(
  (ref) => SingUpController(),
);

class SingUpController extends StateNotifier<SignUpState> with CoreRequestWorkedMixin {
  // Использование service locator для инъекции зависимости.
  SingUpController()
      : _signUpWithEmailUseCase = sl(),
        super(const SignUpState._());

  final GlobalSignUpWithEmailUseCase _signUpWithEmailUseCase;

  String _email = CoreConstant.empty;
  String _name = CoreConstant.empty;
  String _surname = CoreConstant.empty;
  String _phone = CoreConstant.empty;
  String _password = CoreConstant.empty;

  /// Метод для входа в систему с использованием электронной почты и пароля.
  Future<void> signUpWithEmail() async {
    final request = _signUpWithEmailUseCase.execute(
      SignUpEmailParam(
        name: _name,
        email: _email,
        surname: _surname,
        password: _password,
      ),
    );

    await launchWithAuthError<void, GlobalAuthException>(
      request: request,
      loading: (isLoading) => state = state.copyWith(isLoading: isLoading),
      resultData: (result) => state = const SignUpState.success(),
      errorData: (exception, status) {
        if (exception?.email != null) {
          state = state.copyWith(errorEmail: exception?.password?.errorMessage);
        } else {
          state = SignUpState.error(exception?.errorMessage ?? CoreConstant.error);
        }
      },
    );
  }

  /// Методы для установки email и пароля, а также для сброса ошибок.
  void setEmail(String email) {
    _email = email;

    /// Вспомогательный метод для сброса ошибок при изменении данных входа.
    if (state.errorEmail?.isNotEmpty == true) {
      state = state.copyWith(errorEmail: null);
    }
  }

  void setName(String name) {
    _name = name;
  }

  void setSurname(String surname) {
    _surname = surname;
  }

  void setPassword(String password) {
    _password = password;
    _validateFields();
  }

  void _validateFields() {
    bool isHaveSymbol = false;
    bool isIncludeName = false;
    bool isEnableLength = _password.length >= 8;
    bool isContainSpace = _password.contains(' ');

    // Проверка на наличие символов или цифр
    isHaveSymbol =
        _password.contains(RegExp(r'\d')) || _password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));

    // Проверка на включение имени или email в пароль
    isIncludeName = _password.toLowerCase().contains(_email.toLowerCase()) ||
        _password.toLowerCase().contains(_name.toLowerCase()) ||
        _password.toLowerCase().contains(_surname.toLowerCase());

    // Определение силы пароля
    PasswordStrength strength = PasswordStrength.weak;
    if (isEnableLength && isHaveSymbol && !isIncludeName && !isContainSpace) {
      // Простая логика для оценки силы пароля
      strength = PasswordStrength.strong;
    }

    // Обновление состояния валидации
    state = state.copyWith(
      validationPassword: ValidationPasswordEntity(
        strength: strength,
        isHaveSymbol: isHaveSymbol,
        isIncludeName: isIncludeName,
        isEnableLength: isEnableLength,
        isContainSpace: isContainSpace,
      ),
    );
  }

  @override
  void dispose() {
    _email = CoreConstant.empty;
    _password = CoreConstant.empty;
    super.dispose();
  }
}
