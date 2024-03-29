import 'package:flutter/material.dart';
import 'dart:math';

class BeChillPainter extends CustomPainter {
  BeChillPainter({
    required this.rating,
    this.center,
    this.fixedSize,
  });

  final double rating;
  Offset? center;
  Size? fixedSize;
  Paint? beChillPaint;
  double? radius;
  double? angle;

  @override
  void paint(Canvas canvas, Size size) {
    if (fixedSize != null) {
      size = fixedSize!;
    }

    radius ??= size.shortestSide - 0.45 * size.shortestSide;
    angle ??= rating * 2 * pi;

    beChillPaint ??= Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.shortestSide / 10
      ..strokeCap = StrokeCap.round
      ..color = Colors.white;
    // ..color = Colors.blueGrey;

    center ??= Offset(
      size.shortestSide - 0.5 * size.shortestSide,
      size.shortestSide - 0.5 * size.shortestSide,
    );

    canvas.drawArc(
      Rect.fromCircle(center: center!, radius: radius!),
      0,
      angle!,
      false,
      beChillPaint!,
    );

    const dp = 1 / 100 * pi;

    // for (double i = 0, a = angle!; a < 2 * pi; i++, a = angle! + 10 * dp * i) {
    for (double a = 2 * pi + 1 / 10 * angle!; a >= angle!; a -= 10 * dp) {
      int angleOffset = (a * (255 / (2 * pi)) - 40 * angle!).toInt();
      beChillPaint!.color = Colors.white.withAlpha(255 - angleOffset);
      // beChillPaint!.color = Colors.blueGrey.withAlpha(255 - angleOffset);

      canvas.drawArc(
        Rect.fromCircle(center: center!, radius: radius!),
        a,
        dp,
        false,
        beChillPaint!,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
