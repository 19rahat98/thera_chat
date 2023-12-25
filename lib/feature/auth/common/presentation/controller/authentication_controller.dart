import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:equatable/equatable.dart';
import 'package:theta_chat/di/service_locator.dart';
import 'package:theta_chat/feature/auth/common/data/repository/authorized_repository.dart';
import 'package:theta_chat/feature/auth/common/domain/entity/user_detail_entity.dart';
import 'package:theta_chat/feature/auth/common/domain/use_cases/authentication_use_cases.dart';

part 'authentication_state.dart';

/// Инициализация StateNotifierProvider для управления аутентификационным состоянием.
/// Этот провайдер используется для создания экземпляра AuthController и вызывает метод checkUserData
/// при инициализации для немедленной проверки статуса пользователя.
final authProvider = StateNotifierProvider<AuthController, AuthenticationState>(
  (ref) => AuthController()..checkUserData(),
);

/// AuthController управляет аутентификационным состоянием приложения.
/// Он расширяет StateNotifier для обеспечения реактивности состояния.
class AuthController extends StateNotifier<AuthenticationState> {
  // Конструктор AuthController.
  // Инициализирует _authRepository и _checkUserAccess с помощью Service Locator.
  // Устанавливает начальное состояние как 'не аутентифицирован'.
  AuthController()
      : _authRepository = sl(),
        _checkUserAccess = sl(),
        super(AuthorizedUserState.unauthenticated());

  // Зависимости для работы с аутентификацией и проверки доступа пользователя.
  final AuthRepository _authRepository;
  final CheckUserAccessUseCase _checkUserAccess;

  // Асинхронный метод для проверки наличия токена доступа пользователя.
  // Обновляет состояние в зависимости от наличия активного токена.
  Future<void> checkUserData() async {
    final status = await _checkUserAccess.execute();
    if (status.isHaveAccessToken) {
      // Пользователь аутентифицирован, обновляем состояние.
      state = AuthorizedUserState.authenticated(
        const UserDetailEntity(),
      );
    } else {
      // Нет активного токена, устанавливаем состояние как 'не аутентифицирован'.
      state = AuthorizedUserState.unauthenticated();
    }
  }

  // Метод для выхода пользователя из системы.
  // Вызывает signOut в _authRepository и обновляет состояние на 'не аутентифицирован'.
  void onSignOut() {
    _authRepository.signOut();
    state = AuthorizedUserState.unauthenticated();
  }
}
