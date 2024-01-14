import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:theta_chat/common/constants/app_core_constant.dart';
import 'package:theta_chat/common/presentation/widgets/app_bar/flex_app_bar.dart';
import 'package:theta_chat/common/presentation/widgets/app_hbox_widget.dart';
import 'package:theta_chat/common/presentation/widgets/app_loading_container.dart';
import 'package:theta_chat/common/presentation/widgets/buttons/app_filled_color_button.dart';
import 'package:theta_chat/common/presentation/widgets/buttons/app_text_button.dart';
import 'package:theta_chat/common/presentation/widgets/keyboard_dismisser.dart';
import 'package:theta_chat/common/presentation/widgets/snack_bars.dart';
import 'package:theta_chat/common/presentation/widgets/textfields/app_label_textfield.dart';
import 'package:theta_chat/config/theme.dart';
import 'package:theta_chat/feature/auth/common/presentation/controller/authentication_controller.dart';
import 'package:theta_chat/feature/auth/forget_password/presentation/ui/forget_password_screen.dart';
import 'package:theta_chat/feature/auth/login/presentation/controller/sign_in_controller.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    listenState(context, ref);
    final state = ref.watch(signInProvider.select((state) {
      if (state is SignInCommonState) {
        return state;
      }
    }));
    final signInController = ref.read(signInProvider.notifier);
    if (state is SignInCommonState) {
      return AppLoadingContainer(
        isLoading: state.isLoading,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: const FlexAppBar('Log in'),
          body: KeyboardDismisser(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  AppLabelTextFieldWidget(
                    autofocus: true,
                    onValueChanged: signInController.setEmail,
                    label: 'Phone number and email',
                    textInputAction: TextInputAction.next,
                    inputType: TextInputType.emailAddress,
                  ),
                  const HBox(16),
                  AppLabelTextFieldWidget(
                    onValueChanged: signInController.setPassword,
                    onSubmitted: (v) {
                      if (state.isButtonIsEnable) {
                        signInController.launchSignIn();
                      }
                    },
                    label: 'Password',
                    isPassword: true,
                    errorMessage: state.errorPassword,
                    textInputAction: TextInputAction.go,
                  ),
                  const HBox(28),
                  AppTextButton(
                    onTap: () => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const ForgetPasswordScreen(),
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    text: 'Forget password',
                    style: AppTextStyle.button1.copyWith(
                      color: AppColors.inDevPrimary,
                    ),
                  ),
                  const HBox(28),
                  AppFilledColorButton(
                    onTap: () {
                      if (state.isButtonIsEnable) {
                        signInController.launchSignIn();
                      }
                    },
                    borderRadiusRadii: 30,
                    color: state.isButtonIsEnable ? AppColors.inDevPrimary : AppColors.grey100,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Text(
                      'Log In',
                      style: AppTextStyle.button1.copyWith(
                        color: state.isButtonIsEnable ? Colors.white : AppColors.grey300,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    }

    return const SizedBox.shrink();
  }

  /// Слушаем все изменение состонии провайдера
  void listenState(BuildContext context, WidgetRef ref) {
    ref.listen<SignInState>(
      signInProvider,
      (previous, current) {
        if (current is FailureSignInState) {
          showErrorSnackBar(context, current.errorMessage ?? CoreConstant.error);
        } else if (current is SuccessSignInState) {
          final authController = ref.read(authProvider.notifier);
          authController.getUserData();
          Navigator.pop(context);
        }
      },
    );
  }
}
