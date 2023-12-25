import 'package:flutter/material.dart';
import 'package:theta_chat/config/theme.dart';

class AppTextButton extends StatelessWidget {
  const AppTextButton({
    Key? key,
    this.onTap,
    this.style,
    this.padding,
    required this.text,
  }) : super(key: key);

  final String text;
  final VoidCallback? onTap;
  final TextStyle? style;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      style: TextButton.styleFrom(
        padding: padding ?? EdgeInsets.zero,
      ),
      child: Text(
        text,
        style: style ?? AppTextStyle.body1.copyWith(color: AppColors.secondary),
        textAlign: TextAlign.center,
      ),
    );
  }
}
