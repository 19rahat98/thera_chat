import 'package:flutter/material.dart';
import 'package:theta_chat/config/theme.dart';
import 'package:theta_chat/utils/mixins/ignore_double_tap_mixim.dart';

/// кнопка с заполненным цветом
class AppFilledColorButton extends StatelessWidget with IgnoreDoubleTapMixin {
  AppFilledColorButton({
    Key? key,
    this.height,
    this.child,
    this.width,
    this.onTap,
    this.borderRadiusRadii = 0.0,
    this.padding,
    this.margin,
    this.color,
  }) : super(key: key);

  /// дочерний элемент
  final Widget? child;

  /// ширина
  final double? width;

  /// высота
  final double? height;

  /// внутреннний отступ
  final EdgeInsetsGeometry? padding;

  /// внешний отступ
  final EdgeInsetsGeometry? margin;

  /// округление фигуры
  final double borderRadiusRadii;

  final Color? color;

  /// обратный вызов при нажатии на виджет
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      margin: margin,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(borderRadiusRadii),
        ),
      ),
      child: ElevatedButton(
        onPressed: () {
          if (!isRedundantClick) {
            onTap?.call();
          }
        },
        style: ElevatedButton.styleFrom(
          elevation: 0,
          padding: padding ?? EdgeInsets.zero,
          backgroundColor: color ?? AppColors.inDevPrimary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadiusRadii),
          ),
        ),
        child: Center(
          child: child,
        ),
      ),
    );
  }
}
