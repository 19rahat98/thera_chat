import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:theta_chat/common/presentation/widgets/buttons/app_icon_button.dart';
import 'package:theta_chat/config/theme.dart';

class AppTileButton extends StatelessWidget {
  const AppTileButton({
    Key? key,
    this.onTap,
    this.enable = true,
    required this.icon,
    required this.title,
  }) : super(key: key);

  final bool enable;
  final String title;
  final String icon;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      dense: true,
      contentPadding: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 16,
      ),
      title: Text(
        title,
        style: AppTextStyle.body1.copyWith(
          color: enable ? AppColors.grey900 : AppColors.secondary,
        ),
      ),
      leading: SvgPicture.asset(
        icon,
        width: 24,
        height: 24,
        color: enable ? AppColors.grey900 : AppColors.secondary,
      ),
      trailing: AppIconButton(
        onPress: () => Navigator.pop(context),
        background: Colors.transparent,
        AppIcons.icArrowRight,
        iconSize: 24,
      ),
    );
  }
}
