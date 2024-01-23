import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:theta_chat/common/presentation/widgets/app_bar/dynamic_app_bar.dart';
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
  final bool _buttonIsActive = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 200, // Set this height
        flexibleSpace: const DynamicAppBar(
          'Forget password',
          backgroundImage: AppImages.icBackgroundForgetPassword,
        ),
        automaticallyImplyLeading: false,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarBrightness: Brightness.dark, // For iOS (dark icons)
          statusBarIconBrightness: Brightness.light, // For Android (dark icons)
        ),
      ),
      body: KeyboardDismisser(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const HBox(36),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: AppLabelTextFieldWidget(
                label: 'Phone number and email',
                labelStyle: AppTextStyle.body1.copyWith(
                  color: AppColors.secondary,
                ),
              ),
            ),
            const HBox(8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Enters the email address you used to register with Thera. You will receive an email to define a new password.',
                style: AppTextStyle.body2.copyWith(
                  color: AppColors.grey500,
                ),
              ),
            ),
            const HBox(16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: AppFilledColorButton(
                onTap: () {},
                borderRadiusRadii: 30,
                color: _buttonIsActive ? AppColors.inDevPrimary : AppColors.grey100,
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Text(
                  'Define new password',
                  style: AppTextStyle.button1.copyWith(
                    color: _buttonIsActive ? Colors.white : AppColors.grey300,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
