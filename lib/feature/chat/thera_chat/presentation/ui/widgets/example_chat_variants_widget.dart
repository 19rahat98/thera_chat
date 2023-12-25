import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:theta_chat/common/presentation/widgets/app_banner_component.dart';
import 'package:theta_chat/common/presentation/widgets/app_hbox_widget.dart';
import 'package:theta_chat/common/presentation/widgets/app_stepper.dart';
import 'package:theta_chat/common/presentation/widgets/app_wbox_widget.dart';
import 'package:theta_chat/config/theme.dart';

// Виджет, который отображается после анимации
class ExampleChatVariantsWidget extends StatefulWidget {
  const ExampleChatVariantsWidget({super.key});

  @override
  State<ExampleChatVariantsWidget> createState() => _ExampleChatVariantsWidgetState();
}

class _ExampleChatVariantsWidgetState extends State<ExampleChatVariantsWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1), // Длительность анимации появления
    );
    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);

    _controller.forward(); // Запуск анимации
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _opacityAnimation,
      builder: (context, child) {
        return Opacity(
          opacity: _opacityAnimation.value,
          child: child,
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 80),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  AppIcons.icSunFilled,
                  color: AppColors.inDevPrimary,
                ),
                const WBox(8),
                Text(
                  'Примеры',
                  style: AppTextStyle.h4,
                ),
              ],
            ),
            const HBox(16),
            const AppBannerComponent(
              text: '"Как бросить человека, которого я не хочу оставлять?"',
            ),
            const HBox(16),
            const AppBannerComponent(
              text: '"Как мне стать уверенным и успешным, когда в этом мире столько плохих людей?"',
            ),
            const HBox(16),
            const AppBannerComponent(text: '"Как перестать чувствовать и начать жизнь?"'),
            const HBox(16),
            const AppStepper(selected: 0),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
