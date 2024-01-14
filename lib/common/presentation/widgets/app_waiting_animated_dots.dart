import 'dart:async';
import 'package:flutter/material.dart';
import 'package:theta_chat/config/theme.dart';

class AppWaitingAnimatedDots extends StatefulWidget {
  const AppWaitingAnimatedDots({super.key});

  @override
  State<AppWaitingAnimatedDots> createState() => _AppWaitingAnimatedDotsState();
}

class _AppWaitingAnimatedDotsState extends State<AppWaitingAnimatedDots>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  Timer? _timer;
  int _highlightedDotIndex = 0;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: true);

    _timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      setState(() {
        _highlightedDotIndex = (_highlightedDotIndex + 1) % 3;
      });
    });
  }

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
        Container(
          margin: const EdgeInsets.only(left: 4, right: 36),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          decoration: BoxDecoration(
            color: AppColors.grey200,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: List.generate(
              3,
              (index) => AnimatedBuilder(
                animation: _controller,
                builder: (_, __) => Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4.0),
                  width: _highlightedDotIndex == index ? 12 : 8,
                  height: _highlightedDotIndex == index ? 12 : 8,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color:
                        _highlightedDotIndex == index ? AppColors.inDevPrimary : AppColors.primary,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _timer?.cancel();
    super.dispose();
  }
}
