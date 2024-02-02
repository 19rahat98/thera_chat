import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:theta_chat/common/constants/app_core_constant.dart';
import 'package:theta_chat/common/presentation/painters/semi_circle.dart';
import 'package:theta_chat/common/presentation/widgets/app_hbox_widget.dart';
import 'package:theta_chat/common/presentation/widgets/app_loading_container.dart';
import 'package:theta_chat/common/presentation/widgets/app_wbox_widget.dart';
import 'package:theta_chat/common/presentation/widgets/buttons/app_filled_color_button.dart';
import 'package:theta_chat/common/presentation/widgets/buttons/app_text_button.dart';
import 'package:theta_chat/common/presentation/widgets/keyboard_dismisser.dart';
import 'package:theta_chat/common/presentation/widgets/snack_bars.dart';
import 'package:theta_chat/common/presentation/widgets/textfields/app_label_textfield.dart';
import 'package:theta_chat/config/theme.dart';
import 'package:theta_chat/feature/auth/common/presentation/controller/authentication_controller.dart';
import 'package:theta_chat/feature/auth/forget_password/presentation/ui/forget_password_screen.dart';
import 'package:theta_chat/feature/auth/login/presentation/controller/sign_in_controller.dart';
import 'package:theta_chat/feature/auth/sign_up/presentation/ui/sign_up_screen.dart';
import 'package:theta_chat/feature/chat/thera_chat/presentation/ui/thera_chat_screen.dart';

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
          backgroundColor: AppColors.grey20,
          body: KeyboardDismisser(
            child: SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .44,
                    child: Stack(
                      fit: StackFit.expand,
                      clipBehavior: Clip.hardEdge,
                      children: [
                        Positioned.fill(
                          child: Image.asset(
                            AppImages.icLoginBackground,
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                        Positioned(
                          top: 83,
                          left: 0,
                          right: 0,
                          child: SvgPicture.asset(
                            AppIcons.icLaunchIcon,
                          ),
                        ),
                        Positioned(
                          left: 0,
                          right: 0,
                          bottom: 0,
                          child: CustomPaint(
                            size: Size(
                                MediaQuery.of(context).size.width, 56), // Size of the semi-circle
                            painter: ConvexSemiCirclePainter(AppColors.grey20),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: AppLabelTextFieldWidget(
                      color: Colors.white,
                      onValueChanged: signInController.setEmail,
                      label: 'Email',
                      textInputAction: TextInputAction.next,
                      inputType: TextInputType.emailAddress,
                      labelStyle: AppTextStyle.body1.copyWith(
                        color: AppColors.secondary,
                      ),
                    ),
                  ),
                  const HBox(16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: AppLabelTextFieldWidget(
                      onValueChanged: signInController.setPassword,
                      onSubmitted: (v) {
                        if (state.isButtonIsEnable) {
                          signInController.launchSignIn();
                        }
                      },
                      color: Colors.white,
                      label: 'Password',
                      isPassword: true,
                      errorMessage: state.errorPassword,
                      textInputAction: TextInputAction.go,
                      labelStyle: AppTextStyle.body1.copyWith(
                        color: AppColors.secondary,
                      ),
                    ),
                  ),
                  const HBox(18),
                  AppFilledColorButton(
                    onTap: () {
                      if (state.isButtonIsEnable) {
                        signInController.launchSignIn();
                      }
                    },
                    borderRadiusRadii: 30,
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    color: state.isButtonIsEnable ? AppColors.inDevPrimary : AppColors.grey100,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Text(
                      'Log in',
                      style: AppTextStyle.button1.copyWith(
                        color: state.isButtonIsEnable ? Colors.white : AppColors.grey300,
                      ),
                    ),
                  ),
                  const HBox(8),
                  AppTextButton(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const ForgetPasswordScreen(),
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    text: 'Forget password',
                    style: AppTextStyle.button3.copyWith(
                      color: AppColors.inDevPrimary,
                    ),
                  ),
                  const HBox(28),
                  Text(
                    'Or continue with',
                    style: AppTextStyle.caption1.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                  const HBox(16),
                  Row(
                    children: [
                      const WBox(16),
                      Expanded(
                        child: AppFilledColorButton(
                          borderRadiusRadii: 30,
                          color: AppColors.grey100,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(AppIcons.icGoogleFilled),
                              const WBox(8),
                              Text(
                                'Google',
                                style: AppTextStyle.button1,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const WBox(18),
                      Expanded(
                        child: AppFilledColorButton(
                          borderRadiusRadii: 30,
                          color: AppColors.grey100,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(AppIcons.icAppleFilled),
                              const WBox(8),
                              Text(
                                'Apple',
                                style: AppTextStyle.button1,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const WBox(16),
                    ],
                  ),
                  const HBox(16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Don’t have account?',
                        style: AppTextStyle.button2.copyWith(
                          color: AppColors.secondary,
                        ),
                      ),
                      AppTextButton(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const SignUpScreen(),
                          ),
                        ),
                        text: 'Create now',
                        style: AppTextStyle.button2.copyWith(
                          color: AppColors.inDevPrimary500,
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                      ),
                    ],
                  ),
                  const HBox(32),
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
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (_) => const TheraChatScreen(),
            ),
            ModalRoute.withName('/'),
          );
        }
      },
    );
  }
}
