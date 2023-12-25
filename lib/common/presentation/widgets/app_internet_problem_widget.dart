import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:theta_chat/common/presentation/widgets/app_hbox_widget.dart';
import 'package:theta_chat/common/presentation/widgets/app_wbox_widget.dart';
import 'package:theta_chat/common/presentation/widgets/buttons/app_filled_color_button.dart';
import 'package:theta_chat/config/theme.dart';

class AppInternetProblemWidget extends StatelessWidget {
  const AppInternetProblemWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(AppIcons.icAlertCircleFilled),
          Text(
            'Проблема соединениям',
            style: AppTextStyle.h4,
          ),
          const HBox(12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Text(
              'Без интернета - время для внутреннего роста и творчества.',
              textAlign: TextAlign.center,
              style: AppTextStyle.h5,
            ),
          ),
          const HBox(20),
          AppFilledColorButton(
            borderRadiusRadii: 30,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            color: AppColors.grey100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(AppIcons.icWorldOutline),
                const WBox(8),
                Text(
                  'Повторить',
                  style: AppTextStyle.button1,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
