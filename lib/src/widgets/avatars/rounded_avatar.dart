import 'package:flutter/material.dart';

import '../../theme/theme.dart';

const _defaultPadding = EdgeInsets.all(16.0);

class RoundedAvatar extends StatelessWidget {
  const RoundedAvatar({
    Key? key,
    required this.child,
    this.padding,
    this.size,
    this.side,
    this.background,
    this.onPressed,
  }) : super(key: key);

  const factory RoundedAvatar.fill({
    Key? key,
    required Widget child,
    EdgeInsets? padding,
    double? size,
    Color background,
    void Function()? onPressed,
  }) = _RoundedFillAvatar;

  const factory RoundedAvatar.border({
    Key? key,
    required Widget child,
    EdgeInsets? padding,
    double? size,
    BorderSide side,
    Color? background,
    void Function()? onPressed,
  }) = _RoundedBorderAvatar;

  final Widget child;
  final EdgeInsets? padding;
  final double? size;
  final BorderSide? side;
  final Color? background;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(SupervielleConstants.radiussm),
        ),
        color: background,
        border: (side == null) ? null : Border.fromBorderSide(side!),
      ),
      child: SizedBox.square(
        dimension: size,
        child: Padding(
          padding: padding ?? _defaultPadding,
          child: child,
        ),
      ),
    );
  }
}

class _RoundedFillAvatar extends RoundedAvatar {
  const _RoundedFillAvatar({
    Key? key,
    required Widget child,
    EdgeInsets? padding,
    double? size,
    Color background = SupervielleColors.grey100,
    void Function()? onPressed,
  }) : super(
          key: key,
          child: child,
          padding: padding,
          size: size,
          background: background,
          onPressed: onPressed,
        );
}

class _RoundedBorderAvatar extends RoundedAvatar {
  const _RoundedBorderAvatar({
    Key? key,
    required Widget child,
    EdgeInsets? padding,
    double? size,
    BorderSide side = const BorderSide(color: SupervielleColors.red200),
    Color? background,
    void Function()? onPressed,
  }) : super(
          key: key,
          child: child,
          padding: padding,
          size: size,
          background: background,
          side: side,
          onPressed: onPressed,
        );
}
