part of 'sign_up_controller.dart';

enum SignUpStatus {
  success,
  failure,
  common,
}

class SignUpState extends Equatable {
  const SignUpState._({
    this.errorMessage,
    this.errorEmail,
    this.isLoading = false,
    this.validationPassword,
    this.status = SignUpStatus.common,
  });

  final bool isLoading;
  final SignUpStatus status;
  final String? errorMessage;
  final String? errorEmail;
  final ValidationPasswordEntity? validationPassword;

  bool get isButtonEnable => validationPassword?.isValid == true;

  // copyWith method
  SignUpState copyWith({
    bool? isLoading,
    String? errorEmail,
    SignUpStatus? status,
    ValidationPasswordEntity? validationPassword,
  }) {
    return SignUpState._(
      errorMessage: null,
      isLoading: isLoading ?? this.isLoading,
      status: status ?? this.status,
      errorEmail: errorEmail ?? this.errorEmail,
      validationPassword: validationPassword ?? this.validationPassword,
    );
  }

  const SignUpState.success() : this._(status: SignUpStatus.success);

  const SignUpState.error(String message)
      : this._(status: SignUpStatus.failure, errorMessage: message);

  @override
  List<Object?> get props => [status, errorMessage, validationPassword, isLoading];
}
