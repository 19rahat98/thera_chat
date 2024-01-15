import 'package:flutter/material.dart';
import 'package:theta_chat/common/presentation/widgets/app_bar/flex_app_bar.dart';
import 'package:theta_chat/common/presentation/widgets/app_hbox_widget.dart';
import 'package:theta_chat/common/presentation/widgets/buttons/app_filled_color_button.dart';
import 'package:theta_chat/config/theme.dart';

class MessageCenterScreen extends StatelessWidget {
  const MessageCenterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grey20,
      appBar: const FlexAppBar('Message Center'),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 20),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppColors.grey300),
              ),
              child: TextField(
                readOnly: true,
                enabled: false,
                maxLines: 4,
                style: AppTextStyle.body1,
                decoration: InputDecoration(
                  hintText: 'Для оперативной помощи и решения проблем.',
                  hintStyle: AppTextStyle.body1.copyWith(
                    color: AppColors.secondary,
                  ),
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                ),
              ),
            ),
            AppFilledColorButton(
              height: 48,
              borderRadiusRadii: 30,
              color: AppColors.grey100,
              child: Text(
                'Отправить',
                style: AppTextStyle.button1.copyWith(
                  color: AppColors.grey300,
                ),
              ),
            ),
            const HBox(24),
            Text(
              'Наша техподдержка всегда готова помочь с любыми техническими вопросами. Обращайтесь к нам в любое время для оперативной помощи и решения проблем.',
              style: AppTextStyle.body1.copyWith(
                color: AppColors.secondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
