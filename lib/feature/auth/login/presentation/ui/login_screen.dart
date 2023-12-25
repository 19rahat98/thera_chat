import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:theta_chat/common/presentation/widgets/app_bar/flex_app_bar.dart';
import 'package:theta_chat/common/presentation/widgets/app_hbox_widget.dart';
import 'package:theta_chat/common/presentation/widgets/app_loading_container.dart';
import 'package:theta_chat/common/presentation/widgets/buttons/app_filled_color_button.dart';
import 'package:theta_chat/common/presentation/widgets/buttons/app_text_button.dart';
import 'package:theta_chat/common/presentation/widgets/keyboard_dismisser.dart';
import 'package:theta_chat/common/presentation/widgets/textfields/app_label_textfield.dart';
import 'package:theta_chat/config/theme.dart';
import 'package:theta_chat/feature/auth/forget_password/presentation/ui/forget_password_screen.dart';
import 'package:theta_chat/feature/auth/login/presentation/controller/sign_in_controller.dart';
import 'package:theta_chat/feature/nav_bar/presentation/ui/main_navigation_bar.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    listenState(context, ref);
    final state = ref.watch(signInProvider);
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
                    onValueChanged: signInController.setEmail,
                    label: 'Phone number and email',
                  ),
                  const HBox(16),
                  AppLabelTextFieldWidget(
                    onValueChanged: signInController.setPassword,
                    label: 'Password',
                    isPassword: true,
                    errorMessage: state.errorPassword,
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
                    onTap: signInController.launchSignIn,
                    borderRadiusRadii: 30,
                    color: AppColors.inDevPrimary,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Text(
                      'Log In',
                      style: AppTextStyle.button1.copyWith(
                        color: Colors.white,
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

  ///
  void listenState(BuildContext context, WidgetRef ref) {
    ref.listen<SignInState>(
      signInProvider,
      (previous, current) {
        if (current is FailureSignInState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("${current.errorMessage}"),
            ),
          );
        } else if (current is SuccessSignInState) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => const MainNavigationBar(),
            ),
          );
        }
      },
    );
  }
}
