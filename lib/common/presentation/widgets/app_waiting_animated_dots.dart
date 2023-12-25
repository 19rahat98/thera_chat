import 'dart:async';
import 'package:flutter/material.dart';
import 'package:theta_chat/common/presentation/widgets/app_wbox_widget.dart';
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
      children: [
        const WBox(24),
        Container(
          padding: const EdgeInsets.fromLTRB(24, 20, 16, 20),
          decoration: BoxDecoration(
            color: AppColors.grey200,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
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
                    border:
                        _highlightedDotIndex == index ? null : Border.all(color: AppColors.primary),
                    color:
                        _highlightedDotIndex == index ? AppColors.inDevPrimary : Colors.transparent,
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
