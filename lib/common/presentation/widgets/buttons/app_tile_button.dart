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
        background: Colors.transparent,
        AppIcons.icArrowRight,
        iconSize: 24,
        color: enable ? AppColors.grey900 : AppColors.secondary,
      ),
    );
  }
}

class AppTileToggle extends StatefulWidget {
  const AppTileToggle({
    Key? key,
    this.onChanged,
    this.enable = true,
    required this.icon,
    required this.title,
  }) : super(key: key);

  final bool enable;
  final String title;
  final String icon;
  final Function(bool)? onChanged;

  @override
  State<AppTileToggle> createState() => _AppTileToggleState();
}

class _AppTileToggleState extends State<AppTileToggle> {
  bool _isEnable = false;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        setState(() {
          _isEnable = !_isEnable;
        });
      },
      dense: true,
      contentPadding: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 16,
      ),
      title: Text(
        widget.title,
        style: AppTextStyle.body1.copyWith(
          color: widget.enable ? AppColors.grey900 : AppColors.secondary,
        ),
      ),
      leading: SvgPicture.asset(
        widget.icon,
        width: 24,
        height: 24,
        color: widget.enable ? AppColors.grey900 : AppColors.secondary,
      ),
      trailing: SizedBox(
        width: 44,
        height: 24,
        child: FittedBox(
          fit: BoxFit.fitWidth,
          child: Switch(
            onChanged: (bool value) {
              setState(() {
                _isEnable = value;
              });
            },
            value: _isEnable,
            activeColor: Colors.white,
            inactiveThumbColor: Colors.white,
            activeTrackColor: AppColors.grey300,
            inactiveTrackColor: AppColors.grey300,
            trackOutlineColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) => AppColors.grey300,
            ),
            trackOutlineWidth: MaterialStateProperty.resolveWith<double?>(
              (Set<MaterialState> states) => 0,
            ),
            thumbIcon: MaterialStateProperty.resolveWith<Icon?>(
              (Set<MaterialState> states) => const Icon(
                Icons.close,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
