import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:theta_chat/config/theme.dart';

class AppIconButton extends StatelessWidget {
  const AppIconButton(
    this.icon, {
    Key? key,
    this.onPress,
    this.color,
    this.background,
    this.iconSize = 22,
  }) : super(key: key);

  final String icon;
  final Color? color;
  final double iconSize;
  final Function()? onPress;
  final Color? background;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: background ?? Colors.white,
      child: IconButton(
        onPressed: onPress,
        splashRadius: 20,
        padding: EdgeInsets.zero,
        constraints: const BoxConstraints(
          maxWidth: 30,
          maxHeight: 30,
        ),
        icon: Center(
          child: SvgPicture.asset(
            icon,
            color: color ?? AppColors.primary,
            width: iconSize,
            height: iconSize,
          ),
        ),
      ),
    );
  }
}
