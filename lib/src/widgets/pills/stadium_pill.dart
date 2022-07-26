import 'package:flutter/material.dart';

import '../../theme/theme.dart';

class StadiumPill extends StatelessWidget {
  const StadiumPill({
    Key? key,
    this.icon,
    required this.label,
    this.padding = const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
    this.radius,
    required this.accentColor,
    required this.backgroundColor,
    required this.borderColor,
    this.onClose,
  }) : super(key: key);

  final IconData? icon;
  final String label;
  final EdgeInsets padding;
  final double? radius;
  final Color accentColor;
  final Color backgroundColor;
  final Color borderColor;
  final void Function()? onClose;

  @override
  Widget build(BuildContext context) {
    final borderSide = BorderSide(
      color: borderColor,
    );

    return GestureDetector(
      child: DecoratedBox(
        decoration: ShapeDecoration(
          shape: (radius == null)
              ? StadiumBorder(side: borderSide)
              : RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(radius!),
                  side: borderSide,
                ),
          color: backgroundColor,
        ),
        child: Padding(
          padding: padding,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null) ...[
                Icon(icon, color: accentColor, size: 16.0),
                const SizedBox(width: 8.0),
              ],
              Flexible(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    label,
                    style: SupervielleTextStyles.xxs.medium.copyWith(
                      color: accentColor,
                    ),
                  ),
                ),
              ),
              if (onClose != null) ...[
                const SizedBox(width: 8.0),
                Icon(SupervielleIcons.close, color: accentColor, size: 16.0),
              ],
            ],
          ),
        ),
      ),
      onTap: onClose,
    );
  }
}
