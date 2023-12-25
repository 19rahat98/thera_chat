import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:equatable/equatable.dart';
import 'package:theta_chat/common/constants/app_core_constant.dart';
import 'package:theta_chat/common/exception/auth_error_entity.dart';
import 'package:theta_chat/di/service_locator.dart';
import 'package:theta_chat/feature/auth/common/data/repository/authorized_repository.dart';
import 'package:theta_chat/feature/auth/common/domain/entity/user_detail_entity.dart';
import 'package:theta_chat/feature/auth/common/domain/use_cases/authentication_use_cases.dart';
import 'package:theta_chat/feature/auth/common/domain/use_cases/get_user_data_use_case.dart';
import 'package:theta_chat/utils/mixins/request_worker_mixin.dart';

part 'authentication_state.dart';

/// Инициализация StateNotifierProvider для управления аутентификационным состоянием.
/// Этот провайдер используется для создания экземпляра AuthController и вызывает метод checkUserData
/// при инициализации для немедленной проверки статуса пользователя.
final authProvider = StateNotifierProvider<AuthController, AuthenticationState>(
  (ref) => AuthController()..checkUserData(),
);

/// AuthController управляет аутентификационным состоянием приложения.
/// Он расширяет StateNotifier для обеспечения реактивности состояния.
class AuthController extends StateNotifier<AuthenticationState> with CoreRequestWorkedMixin {
  // Конструктор AuthController.
  // Инициализирует _authRepository и _checkUserAccess с помощью Service Locator.
  // Устанавливает начальное состояние как 'не аутентифицирован'.
  AuthController()
      : _getUserData = sl(),
        _authRepository = sl(),
        _checkUserAccess = sl(),
        super(const AuthenticationState._());

  // Зависимости для работы с аутентификацией и проверки доступа пользователя.
  final AuthRepository _authRepository;
  final GlobalGetUserDataUseCase _getUserData;
  final CheckUserAccessUseCase _checkUserAccess;

  // Асинхронный метод для проверки наличия токена доступа пользователя.
  // Обновляет состояние в зависимости от наличия активного токена.
  Future<void> checkUserData() async {
    final status = await _checkUserAccess.execute();
    if (status.isHaveAccessToken) {
      await getUserData();
    } else {
      // Нет активного токена, устанавливаем состояние как 'не аутентифицирован'.
      state = const AuthenticationState.unauthenticated();
    }
  }

  /// Получаем данные об юзера
  Future<void> getUserData() async {
    final request = _getUserData.execute();

    await launchWithAuthError<UserDetailEntity, GlobalAuthException>(
      request: request,
      resultData: (userData) {
        // Пользователь аутентифицирован, обновляем состояние.
        state = AuthenticationState.authenticated(userData);
      },
      errorData: (exception, type) {
        state = AuthenticationState.error(exception?.message ?? CoreConstant.empty);
      },
    );
  }

  // Метод для выхода пользователя из системы.
  // Вызывает signOut в _authRepository и обновляет состояние на 'не аутентифицирован'.
  void onSignOut() {
    _authRepository.signOut();
    state = const AuthenticationState.unauthenticated();
  }
}
