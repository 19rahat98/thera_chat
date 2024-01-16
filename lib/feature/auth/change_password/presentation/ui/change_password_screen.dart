import 'package:flutter/material.dart';
import 'package:theta_chat/common/presentation/widgets/app_bar/flex_app_bar.dart';
import 'package:theta_chat/common/presentation/widgets/app_hbox_widget.dart';
import 'package:theta_chat/common/presentation/widgets/app_terms_and_policy_widget.dart';
import 'package:theta_chat/common/presentation/widgets/buttons/app_filled_color_button.dart';
import 'package:theta_chat/common/presentation/widgets/keyboard_dismisser.dart';
import 'package:theta_chat/common/presentation/widgets/screen/app_adaptive_layout_screen.dart';
import 'package:theta_chat/common/presentation/widgets/textfields/app_label_textfield.dart';
import 'package:theta_chat/config/theme.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      child: Scaffold(
        appBar: const FlexAppBar(
          'Сhange password',
          backgroundColor: AppColors.grey20,
        ),
        backgroundColor: AppColors.grey20,
        body: AppAdaptiveLayoutScreen(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          footer: Column(
            children: [
              const AppTermsAndPolicyWidget(),
              const HBox(16),
              AppFilledColorButton(
                borderRadiusRadii: 30,
                color: AppColors.grey100,
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Text(
                  'Сохранить',
                  style: AppTextStyle.button1.copyWith(
                    color: AppColors.grey300,
                  ),
                ),
              ),
              const HBox(16),
            ],
          ),
          child: const Column(
            children: [
              HBox(40),
              AppLabelTextFieldWidget(
                isPassword: true,
                label: 'Current password',
              ),
              HBox(16),
              AppLabelTextFieldWidget(
                isPassword: true,
                label: 'New password',
              ),
              HBox(16),
              AppLabelTextFieldWidget(
                isPassword: true,
                label: 'Repeat new password',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
