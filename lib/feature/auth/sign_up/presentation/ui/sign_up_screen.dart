import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:theta_chat/common/constants/app_core_constant.dart';
import 'package:theta_chat/common/presentation/widgets/app_bar/flex_app_bar.dart';
import 'package:theta_chat/common/presentation/widgets/app_hbox_widget.dart';
import 'package:theta_chat/common/presentation/widgets/app_loading_container.dart';
import 'package:theta_chat/common/presentation/widgets/buttons/app_filled_color_button.dart';
import 'package:theta_chat/common/presentation/widgets/keyboard_dismisser.dart';
import 'package:theta_chat/common/presentation/widgets/snack_bars.dart';
import 'package:theta_chat/common/presentation/widgets/textfields/app_label_textfield.dart';
import 'package:theta_chat/config/theme.dart';
import 'package:theta_chat/feature/auth/common/presentation/controller/authentication_controller.dart';
import 'package:theta_chat/feature/auth/sign_up/presentation/controller/sign_up_controller.dart';
import 'package:theta_chat/feature/auth/sign_up/presentation/ui/widgets/password_validation_errors.dart';
import 'package:theta_chat/feature/nav_bar/presentation/ui/main_navigation_bar.dart';

class SignUpScreen extends ConsumerWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    listenState(context, ref);
    final state = ref.watch(signUpProvider);
    final signUpController = ref.read(signUpProvider.notifier);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const FlexAppBar('Sign up'),
      body: AppLoadingContainer(
        isLoading: state.isLoading,
        child: KeyboardDismisser(
          child: LayoutBuilder(builder: (context, constraints) {
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minWidth: constraints.maxWidth,
                  minHeight: constraints.maxHeight,
                ),
                child: IntrinsicHeight(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const HBox(16),
                      AppLabelTextFieldWidget(
                        autofocus: true,
                        label: 'First name',
                        textInputAction: TextInputAction.next,
                        onValueChanged: signUpController.setName,
                      ),
                      const HBox(8),
                      AppLabelTextFieldWidget(
                        label: 'Last name',
                        textInputAction: TextInputAction.next,
                        onValueChanged: signUpController.setSurname,
                      ),
                      const HBox(8),
                      Text(
                        'Make sure it matches the name on your government ID.',
                        style: AppTextStyle.body2.copyWith(
                          color: AppColors.grey500,
                        ),
                      ),
                      const HBox(16),
                      AppLabelTextFieldWidget(
                        inputType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        label: 'Phone number and email',
                        onValueChanged: signUpController.setEmail,
                      ),
                      const HBox(8),
                      Text(
                        'We will email you trip confirmations and receipts.',
                        style: AppTextStyle.body2.copyWith(
                          color: AppColors.grey500,
                        ),
                      ),
                      const HBox(16),
                      AppLabelTextFieldWidget(
                        label: 'Password',
                        isPassword: true,
                        onSubmitted: (v) {
                          if (state.isButtonEnable) {
                            signUpController.signUpWithEmail();
                          }
                        },
                        onValueChanged: signUpController.setPassword,
                      ),
                      const HBox(20),
                      PasswordValidationErrors(state.validationPassword),
                      const HBox(20),
                      const Expanded(
                        child: SizedBox(),
                      ),
                      RichText(
                        textAlign: TextAlign.start,
                        text: TextSpan(
                          text: 'By selecting Agree and continue, I agree to ',
                          style: AppTextStyle.body2,
                          children: <TextSpan>[
                            TextSpan(
                              text: 'Th3ra',
                              style: AppTextStyle.body2.copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            TextSpan(
                              text: ' Terms of Service, Payments Terms of Service ',
                              style: AppTextStyle.body2.copyWith(
                                color: AppColors.inDevPrimary,
                              ),
                            ),
                            TextSpan(
                              text: 'and',
                              style: AppTextStyle.body2,
                            ),
                            TextSpan(
                              text: ' Notification Policy',
                              style: AppTextStyle.body2.copyWith(
                                color: AppColors.inDevPrimary,
                              ),
                            ),
                            TextSpan(
                              text: ' and acknowledge the ',
                              style: AppTextStyle.body2,
                            ),
                            TextSpan(
                              text: 'Privacy Policy.',
                              style: AppTextStyle.body2.copyWith(
                                color: AppColors.inDevPrimary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const HBox(16),
                      AppFilledColorButton(
                        onTap: () {
                          if (state.isButtonEnable) {
                            signUpController.signUpWithEmail();
                          }
                        },
                        borderRadiusRadii: 30,
                        color: state.isButtonEnable ? AppColors.inDevPrimary : AppColors.grey100,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: Text(
                          'Sign up',
                          style: AppTextStyle.button1.copyWith(
                            color: state.isButtonEnable ? Colors.white : AppColors.grey300,
                          ),
                        ),
                      ),
                      const HBox(16),
                    ],
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  /// Слушаем все изменение состонии провайдера
  void listenState(BuildContext context, WidgetRef ref) {
    ref.listen<SignUpState>(
      signUpProvider,
      (previous, current) {
        if (current.status == SignUpStatus.failure) {
          showErrorSnackBar(context, current.errorMessage ?? CoreConstant.error);
        } else if (current.status == SignUpStatus.success) {
          final authController = ref.read(authProvider.notifier);
          authController.getUserData();
          Navigator.pop(context);
        }
      },
    );
  }
}
