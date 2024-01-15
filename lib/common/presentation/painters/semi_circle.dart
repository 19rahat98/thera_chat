import 'package:flutter/material.dart';

class ConvexSemiCirclePainter extends CustomPainter {
  ConvexSemiCirclePainter(this.color);

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    var rect = Offset.zero & size;
    var paint = Paint()
      ..color = color // Change the color of the semi-circle here
      ..style = PaintingStyle.fill;

    var center = Offset(size.width / 2, 0);
    var path = Path();
    path.addArc(
      Rect.fromCenter(center: center, width: rect.width + 30, height: rect.height + 100),
      degreesToRadians(180),
      degreesToRadians(180),
    );
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }

  double degreesToRadians(double degrees) {
    return degrees * (3.14159265359 / 180);
  }
}

class SemiCirclePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.blue // Change this to change the color of the semi-circle
      ..style = PaintingStyle.fill;

    Path path = Path();
    path.addArc(
      Rect.fromLTWH(0, 0, size.width, size.height * 2),
      degreesToRadians(180),
      degreesToRadians(180),
    );

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }

  double degreesToRadians(double degrees) {
    return degrees * (3.14159265359 / 180);
  }
}
