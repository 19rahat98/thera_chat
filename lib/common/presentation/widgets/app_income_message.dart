import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:theta_chat/common/presentation/widgets/app_common_divider_widget.dart';
import 'package:theta_chat/config/theme.dart';

class AppAssistantMessage extends StatelessWidget {
  const AppAssistantMessage(
    this.message, {
    Key? key,
    this.enableAdditionAction = false,
  }) : super(key: key);

  final String message;
  final bool enableAdditionAction;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        SizedBox(
          width: 20,
          height: 20,
          child: Image.asset(AppIcons.icAssistantLogo),
        ),
        Flexible(
          child: Container(
            padding: const EdgeInsets.only(top: 20),
            margin: const EdgeInsets.only(left: 4, right: 36),
            decoration: BoxDecoration(
              color: AppColors.grey200,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Visibility(
              visible: enableAdditionAction,
              replacement: Padding(
                padding: const EdgeInsets.only(left: 20, right: 16, bottom: 16),
                child: Text(
                  message,
                  style: AppTextStyle.body1,
                ),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 16, bottom: 16),
                    child: Text(
                      message,
                      style: AppTextStyle.body1,
                    ),
                  ),
                  const AppCommonDividerWidget(indentValue: 0),
                  Material(
                    color: AppColors.grey200,
                    clipBehavior: Clip.hardEdge,
                    borderRadius: const BorderRadius.only(
                      bottomRight: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                    ),
                    child: ListTile(
                      onTap: () {},
                      title: Text(
                        'Meditation',
                        style: AppTextStyle.body3,
                      ),
                      subtitle: Text(
                        'Therachat module',
                        style: AppTextStyle.body2.copyWith(
                          color: AppColors.black.withOpacity(0.5),
                        ),
                      ),
                      trailing: Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: AppColors.black.withOpacity(0.05),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: SvgPicture.asset(
                            AppIcons.icArrowRight,
                            width: 20,
                          ),
                        ),
                      ),
                      leading: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: AppColors.primary.withOpacity(0.4),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: SvgPicture.asset(
                            AppIcons.icMeditationOutline,
                            width: 20,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
