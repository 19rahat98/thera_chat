import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:theta_chat/common/presentation/widgets/app_wbox_widget.dart';
import 'package:theta_chat/common/presentation/widgets/buttons/app_icon_button.dart';
import 'package:theta_chat/config/theme.dart';

class FlexAppBar extends StatelessWidget implements PreferredSizeWidget {
  const FlexAppBar(
    this.title, {
    super.key,
    this.height,
    this.actions,
  });

  final double? height;
  final String title;
  final List<Widget>? actions;

  @override
  Size get preferredSize => Size.fromHeight(height ?? 60);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      centerTitle: true,
      actions: actions,
      backgroundColor: Colors.white,
      leading: AppIconButton(
        AppIcons.icArrowLeft,
        onPress: () => Navigator.pop(context),
        iconSize: 30,
      ),
      title: Text(title, style: AppTextStyle.h4),
    );
  }
}
