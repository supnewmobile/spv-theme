import 'package:flutter/material.dart';

import '../../theme/theme.dart';

class ActionButton extends StatelessWidget {
  ActionButton({
    Key? key,
    required IconData icon,
    Color color = SupervielleColors.grey900,
    Color? overlay,
    this.radius = 40.0,
    this.padding = const EdgeInsets.all(8.0),
    this.onTap,
  })  : child = Icon(icon, color: color),
        overlay = overlay ?? SupervielleColors.overlay,
        super(key: key);

  ActionButton.child({
    Key? key,
    required this.child,
    this.radius = 40.0,
    this.padding = const EdgeInsets.all(8.0),
    this.onTap,
  })  : overlay = SupervielleColors.overlay,
        super(key: key);

  final Widget child;
  final double radius;
  final EdgeInsets padding;
  final Color overlay;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: (onTap == null) ? 0.5 : 1.0,
      child: InkResponse(
        child: Padding(
          padding: padding,
          child: child,
        ),
        overlayColor: MaterialStateProperty.all<Color>(overlay),
        radius: radius,
        onTap: onTap,
      ),
    );
  }
}
