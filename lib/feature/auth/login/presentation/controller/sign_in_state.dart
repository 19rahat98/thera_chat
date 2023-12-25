part of 'sign_in_controller.dart';

abstract class SignInState extends Equatable {}

class SignInCommonState extends SignInState {
  SignInCommonState({
    this.isLoading = false,
    this.errorPassword,
  });

  final bool isLoading;
  final String? errorPassword;

  SignInCommonState copyWith({
    bool? isLoading,
    String? errorPassword,
  }) =>
      SignInCommonState(
        isLoading: isLoading ?? this.isLoading,
        errorPassword: errorPassword ?? this.errorPassword,
      );

  @override
  List<Object?> get props => [isLoading, errorPassword];
}

class FailureSignInState extends SignInState {
  FailureSignInState({this.errorMessage});

  final String? errorMessage;
  final index = DateTime.now().millisecondsSinceEpoch;

  @override
  List<Object?> get props => [errorMessage, index];
}

class SuccessSignInState extends SignInState {
  @override
  List<Object?> get props => [];
}
