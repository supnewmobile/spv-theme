import 'dart:math';

import 'package:flutter/material.dart';
import 'package:spv_theme/spv_theme.dart';


class PageIndicator extends StatelessWidget {
  const PageIndicator({
    Key? key,
    required this.length,
    required this.page,
    this.spacing = 8.0,
    this.activeColor = SupervielleColors.red900,
    this.inactiveColor = SupervielleColors.grey400,
    this.activeWidth = 24.0,
    this.inactiveWidth = 8.0,
  }) : super(key: key);

  final int length;
  final double page;
  final double spacing;
  final Color activeColor;
  final Color inactiveColor;
  final double activeWidth;
  final double inactiveWidth;

  @override
  Widget build(BuildContext context) {
    final l = length - 1;
    final indicatorsWidth = inactiveWidth * l + activeWidth + spacing * l;

    return ConstrainedBox(
      constraints: BoxConstraints.tightFor(width: indicatorsWidth, height: inactiveWidth),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(
          length,
          (i) {
            final percentage = (i - page).abs();
            final factor = 1.0 - (percentage.clamp(0.0, 1.0));
            final width = activeWidth * factor;
            final color = Color.lerp(inactiveColor, activeColor, factor);

            return Container(
              width: max(inactiveWidth, width),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(inactiveWidth * 0.5),
                color: color,
              ),
            );
          },
        ),
      ),
    );
  }
}
