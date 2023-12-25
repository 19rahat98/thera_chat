import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:theta_chat/config/theme.dart';
import 'package:theta_chat/feature/chat/thera_chat/presentation/ui/thera_chat_screen.dart';
import 'package:theta_chat/feature/nav_bar/presentation/ui/widgets/nav_bar_icon_item_widget.dart';
import 'package:theta_chat/feature/settings/presentation/settings_screen.dart';

class MainNavigationBar extends StatefulWidget {
  const MainNavigationBar({Key? key}) : super(key: key);

  @override
  State<MainNavigationBar> createState() => _MainNavigationBarState();
}

class _MainNavigationBarState extends State<MainNavigationBar> {
  /// табы нижней навигации
  List<PersistentBottomNavBarItem> get _tabs => [
        PersistentBottomNavBarItem(
          icon: const NavBarIconItemWidget(
            title: 'Home',
            iconName: AppIcons.icHomeOutline,
            iconColor: AppColors.inDevPrimary,
            textColor: AppColors.inDevPrimary,
          ),
          inactiveIcon: const NavBarIconItemWidget(
            title: 'Home',
            iconName: AppIcons.icHomeOutline,
            iconColor: AppColors.secondary,
            textColor: AppColors.secondary,
          ),
        ),
        PersistentBottomNavBarItem(
          icon: const NavBarIconItemWidget(
            title: 'Meditation',
            iconName: AppIcons.icMeditationBody,
            iconColor: AppColors.inDevPrimary,
            textColor: AppColors.inDevPrimary,
          ),
          inactiveIcon: const NavBarIconItemWidget(
            title: 'Meditation',
            iconName: AppIcons.icMeditationBody,
            iconColor: AppColors.secondary,
            textColor: AppColors.secondary,
          ),
        ),
        PersistentBottomNavBarItem(
          icon: Container(
            width: 52,
            height: 52,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.inDevPrimary,
            ),
            child: Center(
              child: SvgPicture.asset(AppIcons.icChatFilled),
            ),
          ),
        ),
        PersistentBottomNavBarItem(
          icon: const NavBarIconItemWidget(
            title: 'Habit',
            iconName: AppIcons.icBookNav,
            iconColor: AppColors.inDevPrimary,
            textColor: AppColors.inDevPrimary,
          ),
          inactiveIcon: const NavBarIconItemWidget(
            title: 'Habit',
            iconName: AppIcons.icBookNav,
            iconColor: AppColors.secondary,
            textColor: AppColors.secondary,
          ),
        ),
        PersistentBottomNavBarItem(
          icon: const NavBarIconItemWidget(
            title: 'Settings',
            iconName: AppIcons.icSettingsOutline,
            iconColor: AppColors.inDevPrimary,
            textColor: AppColors.inDevPrimary,
          ),
          inactiveIcon: const NavBarIconItemWidget(
            title: 'Settings',
            iconName: AppIcons.icSettingsOutline,
            iconColor: AppColors.secondary,
            textColor: AppColors.secondary,
          ),
        ),
      ];

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      items: _tabs,
      navBarHeight: 70,
      screens: const [SizedBox(), SizedBox(), TheraChatScreen(), SizedBox(), SettingsScreen()],
      onItemSelected: (index) {},
      padding: const NavBarPadding.only(top: 10),
      selectedTabScreenContext: (context) {},
      resizeToAvoidBottomInset: true,
      hideNavigationBarWhenKeyboardShows: false,
      backgroundColor: Colors.white,
      bottomScreenMargin: 45,
      itemAnimationProperties: const ItemAnimationProperties(
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      navBarStyle: NavBarStyle.style2,
    );
  }
}
