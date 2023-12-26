import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:theta_chat/common/presentation/widgets/app_hbox_widget.dart';
import 'package:theta_chat/config/theme.dart';

class NavBarIconItemWidget extends StatelessWidget {
  const NavBarIconItemWidget({
    Key? key,
    this.iconColor,
    this.textColor,
    required this.title,
    required this.iconName,
  }) : super(key: key);

  final String iconName;
  final Color? iconColor;
  final Color? textColor;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        SvgPicture.asset(
          iconName,
          width: 24,
          height: 24,
          color: iconColor,
        ),
        const HBox(4),
        Material(
          color: Colors.transparent,
          child: Text(
            title,
            style: AppTextStyle.caption1.copyWith(color: textColor),
          ),
        ),
      ],
    );
  }
}
