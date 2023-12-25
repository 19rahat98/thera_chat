part of 'authentication_controller.dart';

enum AuthenticationStatus {
  authenticated,
  unauthenticated,
}

abstract class AuthenticationState extends Equatable {}

class AuthorizedUserState extends AuthenticationState {
  AuthorizedUserState._({
    this.user,
    required this.status,
  });

  final UserDetailEntity? user;
  final AuthenticationStatus status;

  AuthorizedUserState.authenticated(UserDetailEntity user)
      : this._(status: AuthenticationStatus.authenticated, user: user);

  AuthorizedUserState.unauthenticated() : this._(status: AuthenticationStatus.unauthenticated);

  @override
  List<Object> get props => [status, user ?? 0];
}

class FailureAuthenticationState extends AuthenticationState {
  @override
  List<Object?> get props => [];
}
