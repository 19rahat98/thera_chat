import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:theta_chat/config/theme.dart';

class AppOutcomeMessage extends StatelessWidget {
  const AppOutcomeMessage(
    this.message, {
    Key? key,
    this.isHaveError = false,
  }) : super(key: key);

  final String message;
  final bool isHaveError;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Visibility(
          visible: isHaveError,
          child: SvgPicture.asset(AppIcons.icInformationFilled),
        ),
        Flexible(
          child: Container(
            margin: EdgeInsets.only(left: isHaveError ? 4 : 36, right: 4),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            decoration: BoxDecoration(
              color: AppColors.inDevPrimary600,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              message,
              style: AppTextStyle.body1.copyWith(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
