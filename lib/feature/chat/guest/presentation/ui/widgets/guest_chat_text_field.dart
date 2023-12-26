import 'package:flutter/material.dart';
import 'package:theta_chat/common/presentation/widgets/buttons/app_icon_button.dart';
import 'package:theta_chat/config/theme.dart';

class GuestChatTextField extends StatelessWidget {
  const GuestChatTextField({
    Key? key,
    required this.controller,
    required this.onSendMessage,
  }) : super(key: key);

  final Function() onSendMessage;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppColors.grey50,
      child: SafeArea(
        top: false,
        child: Container(
          color: AppColors.grey50,
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppColors.grey300),
            ),
            child: TextField(
              autofocus: true,
              controller: controller,
              style: AppTextStyle.body1,
              onSubmitted: (v) => onSendMessage,
              decoration: InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                suffixIcon: Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: AppColors.grey50,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: AppIconButton(
                    AppIcons.icSendOutline,
                    onPress: onSendMessage,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
