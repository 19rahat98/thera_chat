part of 'sign_in_controller.dart';

abstract class SignInState extends Equatable {}

class SignInCommonState extends SignInState {
  SignInCommonState({
    this.errorPassword,
    this.isLoading = false,
    this.isButtonIsEnable = false,
  });

  final bool isLoading;
  final bool isButtonIsEnable;
  final String? errorPassword;

  SignInCommonState copyWith({
    bool? isLoading,
    bool? isButtonIsEnable,
    String? errorPassword,
  }) =>
      SignInCommonState(
        isLoading: isLoading ?? this.isLoading,
        errorPassword: errorPassword ?? this.errorPassword,
        isButtonIsEnable: isButtonIsEnable ?? this.isButtonIsEnable,
      );

  @override
  List<Object?> get props => [isLoading, errorPassword, isButtonIsEnable];
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
