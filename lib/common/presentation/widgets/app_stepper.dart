import 'package:flutter/material.dart';
import 'package:theta_chat/config/theme.dart';

class AppStepper extends StatelessWidget {
  const AppStepper({
    Key? key,
    this.qty = 3,
    this.size = 8,
    required this.selected,
  }) : super(key: key);

  final int qty;
  final double size;
  final int selected;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        qty,
        (index) => Container(
          width: size,
          height: size,
          margin: const EdgeInsets.only(right: 12),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: selected == index ? AppColors.inDevPrimary : AppColors.inDevPrimary100,
          ),
        ),
      ),
    );
  }
}
