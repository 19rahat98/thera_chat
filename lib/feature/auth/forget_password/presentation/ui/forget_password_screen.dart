import 'package:flutter/material.dart';
import 'package:theta_chat/common/presentation/widgets/app_bar/flex_app_bar.dart';
import 'package:theta_chat/common/presentation/widgets/app_hbox_widget.dart';
import 'package:theta_chat/common/presentation/widgets/buttons/app_filled_color_button.dart';
import 'package:theta_chat/common/presentation/widgets/keyboard_dismisser.dart';
import 'package:theta_chat/common/presentation/widgets/textfields/app_label_textfield.dart';
import 'package:theta_chat/config/theme.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  bool _buttonIsActive = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const FlexAppBar('Forget password'),
      body: KeyboardDismisser(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const AppLabelTextFieldWidget(
                label: 'Phone number and email',
              ),
              const HBox(8),
              Text(
                'Enters the email address you used to register with Thera. You will receive an email to define a new password.',
                style: AppTextStyle.body2.copyWith(
                  color: AppColors.grey500,
                ),
              ),
              const HBox(16),
              AppFilledColorButton(
                onTap: () {
                  if (_buttonIsActive) {
                    return;
                  }
                  setState(() {
                    _buttonIsActive = true;
                  });
                },
                borderRadiusRadii: 30,
                color: _buttonIsActive ? AppColors.inDevPrimary : AppColors.grey100,
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Text(
                  'Define new password',
                  style: AppTextStyle.button1.copyWith(
                    color: _buttonIsActive ? Colors.white : AppColors.grey300,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
