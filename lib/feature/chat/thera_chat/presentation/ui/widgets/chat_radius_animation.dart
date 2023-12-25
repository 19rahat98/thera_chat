import 'package:flutter/material.dart';

class ChatRadiusAnimation extends StatefulWidget {
  const ChatRadiusAnimation({
    Key? key,
    required this.onComplete,
  }) : super(key: key);

  final Function() onComplete;

  @override
  State<ChatRadiusAnimation> createState() => _ChatRadiusAnimationState();
}

class _ChatRadiusAnimationState extends State<ChatRadiusAnimation>
    with SingleTickerProviderStateMixin {
  late Animation<double> _animation;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _animation = Tween<double>(begin: 0.1, end: 0.3).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          widget.onComplete.call();
        }
      });

    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          width: 200,
          height: 200,
          clipBehavior: Clip.none,
          decoration: BoxDecoration(
            gradient: RadialGradient(
              radius: _animation.value,
              center: const Alignment(0, 0),
              colors: [
                const Color(0xFFAA00F3),
                const Color(0xFFD267FF).withOpacity(0),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
