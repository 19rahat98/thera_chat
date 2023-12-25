import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:theta_chat/common/constants/app_core_constant.dart';
import 'package:theta_chat/common/exception/auth_error_entity.dart';
import 'package:theta_chat/di/service_locator.dart';
import 'package:theta_chat/feature/auth/login/domain/use_cases/sign_in_with_email_use_case.dart';
import 'package:theta_chat/utils/mixins/request_worker_mixin.dart';

part 'sign_in_state.dart';

final signInProvider = StateNotifierProvider<SingInController, SignInState>(
  (ref) => SingInController(),
);

class SingInController extends StateNotifier<SignInState> with CoreRequestWorkedMixin {
  SingInController()
      : _signInUseCase = sl(),
        super(SignInCommonState());

  final GlobalSignInWithEmailUseCase _signInUseCase;

  String _email = CoreConstant.empty;
  String _password = CoreConstant.empty;

  Future<void> signInWithEmail(String email, password) async {
    final state = _getCommonState();
    final request = _signInUseCase.execute(
      SignInEmailParam(email, password),
    );

    await launchWithAuthError<void, GlobalAuthException>(
      request: request,
      loading: (isLoading) => this.state = state.copyWith(isLoading: isLoading),
      resultData: (result) {
        this.state = SuccessSignInState();
      },
      errorData: (exception, status) {
        if (exception?.password != null) {
          this.state = state.copyWith(errorPassword: exception?.password?.errorMessage);
        }
        this.state = FailureSignInState();
      },
    );
  }

  void launchSignIn() => signInWithEmail(_email, _password);

  void setPassword(String password) {
    _password = password;
    final state = _getCommonState();
    if (state.errorPassword?.isNotEmpty == true) {
      this.state = state.copyWith(errorPassword: null);
    }
  }

  void setEmail(String email) {
    _email = email;
    final state = _getCommonState();
    if (state.errorPassword?.isNotEmpty == true) {
      this.state = state.copyWith(errorPassword: null);
    }
  }

  SignInCommonState _getCommonState() {
    if (state is SignInCommonState) {
      return state as SignInCommonState;
    }
    return SignInCommonState();
  }
}
