import 'package:flutter/material.dart';
import 'package:theta_chat/config/theme.dart';
import 'package:theta_chat/utils/mixins/ignore_double_tap_mixim.dart';

class AppOutlineButtonWidget extends StatelessWidget with IgnoreDoubleTapMixin {
  AppOutlineButtonWidget({
    Key? key,
    this.height,
    this.child,
    this.width,
    this.onTap,
    this.borderRadiusRadii = 0.0,
    this.padding,
    this.color,
    this.borderColor,
    this.constraints,
  }) : super(key: key);

  /// дочерний элемент
  final Widget? child;

  /// ширина
  final double? width;

  /// высота
  final double? height;

  /// внутреннний отступ
  final EdgeInsetsGeometry? padding;

  /// округление фигуры
  final double borderRadiusRadii;

  /// обратный вызов при нажатии на виджет
  final GestureTapCallback? onTap;

  /// цвет виджета
  final Color? color;

  /// цвет виджета
  final Color? borderColor;

  final BoxConstraints? constraints;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: constraints ??
          BoxConstraints(
            minHeight: height ?? 0,
            minWidth: width ?? 0,
          ),
      child: OutlinedButton(
        onPressed: () {
          if (!isRedundantClick) {
            onTap?.call();
          }
        },
        style: OutlinedButton.styleFrom(
          elevation: 0,
          backgroundColor: color,
          padding: padding ?? EdgeInsets.zero,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          side: BorderSide(
            color: borderColor ?? AppColors.primary,
          ),
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
