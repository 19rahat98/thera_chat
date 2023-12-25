import 'package:flutter/material.dart';
import 'package:theta_chat/config/theme.dart';

class AppCommonDividerWidget extends StatelessWidget {
  const AppCommonDividerWidget({
    Key? key,
    this.color,
    this.height,
    this.thickness,
    this.indentValue,
  }) : super(key: key);

  /// цвет виджета
  final Color? color;

  /// отступ с края
  final double? indentValue;

  final double? height;

  /// толщина дивайдера
  final double? thickness;

  @override
  Widget build(BuildContext context) {
    return Divider(
      thickness: thickness ?? 1,
      height: height ?? 0,
      endIndent: indentValue ?? 20,
      indent: indentValue ?? 20,
      color: color ?? AppColors.grey300,
    );
  }
}
