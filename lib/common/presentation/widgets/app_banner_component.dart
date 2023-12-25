import 'package:flutter/material.dart';
import 'package:theta_chat/config/theme.dart';

class AppBannerComponent extends StatelessWidget {
  const AppBannerComponent({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.grey100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        text,
        style: AppTextStyle.body2,
        textAlign: TextAlign.center,
      ),
    );
  }
}
