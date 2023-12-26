import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:theta_chat/common/presentation/widgets/app_wbox_widget.dart';
import 'package:theta_chat/common/presentation/widgets/buttons/app_icon_button.dart';
import 'package:theta_chat/config/theme.dart';
import 'package:theta_chat/feature/chat/guest/presentation/ui/guest_chat_screen.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CommonAppBar({
    super.key,
    this.height,
    this.leadingIcon,
    this.leadingSize = 22,
    required this.onPressLeading,
  });

  final double? height;
  final double leadingSize;
  final String? leadingIcon;
  final Function() onPressLeading;

  @override
  Size get preferredSize => Size.fromHeight(height ?? 60);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      centerTitle: true,
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.transparent,
      leading: AppIconButton(
        onPress: onPressLeading,
        leadingIcon ?? AppIcons.icUserOutline,
        iconSize: leadingSize,
      ),
      title: SvgPicture.asset(
        AppIcons.icAppIcon,
      ),
      actions: [
        AppIconButton(
          AppIcons.icQuestionOutline,
          onPress: () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => const GuestChatScreen(),
            ),
          ),
        ),
        const WBox(10),
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(4.0),
        child: Container(
          color: AppColors.grey200,
          height: 1.0,
        ),
      ),
    );
  }
}
