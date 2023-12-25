import 'package:flutter/material.dart';
import 'package:theta_chat/common/presentation/widgets/app_bar/flex_app_bar.dart';
import 'package:theta_chat/common/presentation/widgets/app_hbox_widget.dart';
import 'package:theta_chat/common/presentation/widgets/buttons/app_filled_color_button.dart';
import 'package:theta_chat/common/presentation/widgets/keyboard_dismisser.dart';
import 'package:theta_chat/common/presentation/widgets/textfields/app_label_textfield.dart';
import 'package:theta_chat/config/theme.dart';
import 'package:theta_chat/feature/auth/sign_up/presentation/ui/widgets/password_validation_errors.dart';
import 'package:theta_chat/feature/nav_bar/presentation/ui/main_navigation_bar.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool _isShowErrors = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const FlexAppBar('Sign up'),
      body: KeyboardDismisser(
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
                    const AppLabelTextFieldWidget(
                      label: 'First name',
                    ),
                    const HBox(8),
                    const AppLabelTextFieldWidget(
                      label: 'Last name',
                    ),
                    const HBox(8),
                    Text(
                      'Make sure it matches the name on your government ID.',
                      style: AppTextStyle.body2.copyWith(
                        color: AppColors.grey500,
                      ),
                    ),
                    const HBox(16),
                    const AppLabelTextFieldWidget(
                      label: 'Phone number and email',
                    ),
                    const HBox(8),
                    Text(
                      'We will email you trip confirmations and receipts.',
                      style: AppTextStyle.body2.copyWith(
                        color: AppColors.grey500,
                      ),
                    ),
                    const HBox(16),
                    const AppLabelTextFieldWidget(
                      label: 'Password',
                      isPassword: true,
                    ),
                    const HBox(20),
                    Visibility(
                      visible: _isShowErrors,
                      child: const PasswordValidationErrors(),
                    ),
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
                        if (_isShowErrors) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const MainNavigationBar(),
                            ),
                          );
                          return;
                        }
                        setState(() {
                          _isShowErrors = true;
                        });
                      },
                      borderRadiusRadii: 30,
                      color: _isShowErrors ? AppColors.inDevPrimary : AppColors.grey100,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Text(
                        'Sign up',
                        style: AppTextStyle.button1.copyWith(
                          color: _isShowErrors ? Colors.white : AppColors.grey300,
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
    );
  }
}
