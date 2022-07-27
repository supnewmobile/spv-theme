import 'dart:math';

import 'package:flutter/material.dart';

import '../../theme/theme.dart';

const Duration _period = Duration(milliseconds: 1500);
const double _outerCirclePercent = 0.25;

class Spinner extends StatefulWidget {
  const Spinner({
    Key? key,
    this.radius = 56.0,
    this.stroke = 8.0,
  }) : super(key: key);

  final double radius;
  final double stroke;

  @override
  _SpinnerState createState() => _SpinnerState();
}

class _SpinnerState extends State<Spinner> with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    const upperBound = pi * 2;
    _animationController = AnimationController(vsync: this, upperBound: upperBound);
    _animationController.repeat(min: 0.0, max: upperBound, period: _period);
  }

  @override
  void dispose() {
    _animationController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.fromSize(
      size: Size.square(widget.radius),
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (_, child) => CustomPaint(
          painter: _SpinnerPainter(
            _animationController.value,
            widget.stroke,
          ),
        ),
      ),
    );
  }
}

class _SpinnerPainter extends CustomPainter {
  const _SpinnerPainter(this.startAngle, this.stroke);

  final double startAngle;
  final double stroke;

  @override
  void paint(Canvas canvas, Size size) {
    final radius = max(size.width, size.height) * 0.5 - stroke * 0.5;

    final innerCirclePaint = Paint()
      ..color = SupervielleColors.grey200
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke;

    final outerCirclePaint = Paint()
      ..color = SupervielleColors.red500
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = stroke;

    final center = Offset(size.width * 0.5, size.height * 0.5);
    canvas.drawCircle(center, radius, innerCirclePaint);

    const arcAngle = 2 * pi * _outerCirclePercent;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle - pi * 0.5,
      arcAngle,
      false,
      outerCirclePaint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) =>
      (oldDelegate is _SpinnerPainter) && (oldDelegate.startAngle != startAngle);
}
