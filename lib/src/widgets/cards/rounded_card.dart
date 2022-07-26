import 'package:flutter/material.dart';
import 'package:spv_theme/spv_theme.dart';


const _borderRadius = BorderRadius.all(
  Radius.circular(SupervielleConstants.radiussm),
);

class RoundedCard extends StatelessWidget {
  const RoundedCard({
    Key? key,
    required this.child,
    this.padding,
    this.onTap,
  }) : super(key: key);

  final Widget child;
  final EdgeInsets? padding;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: ShapeDecoration(
        shape: const RoundedRectangleBorder(
          borderRadius: _borderRadius,
          side: BorderSide(
            color: SupervielleColors.grey200,
          ),
        ),
        shadows: [if (onTap != null) SupervielleConstants.boxShadow.grey300],
      ),
      child: Material(
        color: SupervielleColors.white,
        borderRadius: _borderRadius,
        child: InkWell(
          borderRadius: _borderRadius,
          child: Padding(padding: padding ?? const EdgeInsets.all(16.0), child: child),
          overlayColor: MaterialStateProperty.all<Color>(SupervielleColors.overlay),
          onTap: onTap,
        ),
      ),
    );
  }
}
