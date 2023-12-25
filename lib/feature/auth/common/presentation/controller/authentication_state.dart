part of 'authentication_controller.dart';

enum AuthenticationStatus {
  init,
  failure,
  authenticated,
  unauthenticated,
}

class AuthenticationState extends Equatable {
  const AuthenticationState._({
    this.user,
    this.errorMessage,
    this.status = AuthenticationStatus.init,
  });

  final String? errorMessage;
  final UserDetailEntity? user;
  final AuthenticationStatus status;

  const AuthenticationState.authenticated(UserDetailEntity user)
      : this._(status: AuthenticationStatus.authenticated, user: user);

  const AuthenticationState.unauthenticated()
      : this._(status: AuthenticationStatus.unauthenticated);

  const AuthenticationState.error(String message)
      : this._(status: AuthenticationStatus.failure, errorMessage: message);

  @override
  List<Object> get props => [status, user ?? 0, errorMessage ?? 0];
}
