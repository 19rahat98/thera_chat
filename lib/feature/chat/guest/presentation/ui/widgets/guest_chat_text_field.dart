import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:theta_chat/config/theme.dart';

class GuestChatTextField extends StatelessWidget {
  const GuestChatTextField({
    Key? key,
    this.autofocus = true,
    required this.controller,
    required this.onSendMessage,
  }) : super(key: key);

  final bool autofocus;
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
          padding: EdgeInsets.fromLTRB(16, 8, 16, MediaQuery.of(context).viewInsets.bottom + 12),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppColors.grey300),
            ),
            child: TextField(
              autofocus: autofocus,
              controller: controller,
              minLines: 1,
              // Минимальное количество строк
              maxLines: 3,
              // Ограничивает количество строк максимум тремя
              keyboardType: TextInputType.multiline,
              // Включает поддержку многострочного ввода
              style: AppTextStyle.body1,
              textInputAction: TextInputAction.send,
              onSubmitted: (v) => onSendMessage(),
              decoration: InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                suffixIconConstraints: const BoxConstraints(
                  maxHeight: 32,
                  maxWidth: 32,
                ),
                suffixIcon: Material(
                  color: AppColors.grey50,
                  borderRadius: BorderRadius.circular(6),
                  child: IconButton(
                    onPressed: onSendMessage,
                    splashRadius: 30,
                    padding: EdgeInsets.zero,
                    icon: SvgPicture.asset(
                      AppIcons.icSendOutline,
                      color: AppColors.grey500,
                      width: 24,
                      height: 24,
                    ),
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
