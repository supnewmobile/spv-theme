import 'package:flutter/material.dart';

import '../../theme/theme.dart';

const _defaultPadding = EdgeInsets.all(16.0);

class CircleButton extends StatelessWidget {
  const CircleButton({
    Key? key,
    required this.child,
    this.label,
    this.minimumSize = Size.zero,
    this.padding,
    required this.onPressed,
  }) : super(key: key);

  factory CircleButton.icon({
    Key? key,
    required IconData icon,
    double? size,
    Color color = SupervielleColors.red500,
    String? label,
    Size minimumSize = Size.zero,
    EdgeInsets? padding,
    required void Function() onPressed,
  }) =>
      CircleButton(
        key: key,
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Icon(icon, size: size, color: color),
        ),
        label: label,
        minimumSize: minimumSize,
        padding: padding,
        onPressed: onPressed,
      );

  final Widget child;
  final String? label;
  final Size minimumSize;
  final EdgeInsets? padding;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [SupervielleConstants.boxShadow.grey300],
          ),
          child: TextButton(
            child: child,
            style: ButtonStyle(
              minimumSize: MaterialStateProperty.all<Size>(minimumSize),
              shape: MaterialStateProperty.all<OutlinedBorder>(
                const CircleBorder(),
              ),
              side: MaterialStateProperty.all<BorderSide>(
                const BorderSide(
                  color: SupervielleColors.grey200,
                ),
              ),
              padding: MaterialStateProperty.all<EdgeInsets>(padding ?? _defaultPadding),
              backgroundColor: MaterialStateProperty.all<Color>(SupervielleColors.white),
              overlayColor: MaterialStateProperty.all<Color>(SupervielleColors.overlay),
            ),
            onPressed: onPressed,
          ),
        ),
        if (label != null) ...[
          const SizedBox(height: 8.0),
          Text(
            label!,
            textAlign: TextAlign.center,
            style: SupervielleTextStyles.xxs.regular.grey800,
          ),
        ],
      ],
    );
  }
}
