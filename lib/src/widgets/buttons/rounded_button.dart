import 'package:flutter/material.dart';

import '../../theme/theme.dart';

abstract class RoundedButton extends StatelessWidget {
  const RoundedButton({
    Key? key,
    required this.text,
    this.minimumSize = const Size.fromHeight(0.0),
    this.padding = const EdgeInsets.all(12.0),
    this.borderSide,
    this.foregroundColor,
    this.backgroundColor,
    this.disabledColor,
    this.opacity = 1.0,
    this.overlay,
    this.onPressed,
  }) : super(key: key);

  const factory RoundedButton.translucent({
    Key? key,
    required String text,
    Color foregroundColor,
    double opacity,
    void Function()? onPressed,
  }) = _RoundedTranslucentButton;

  const factory RoundedButton.fill({
    Key? key,
    required String text,
    Color foregroundColor,
    Color backgroundColor,
    Color disabledColor,
    Color overlay,
    void Function()? onPressed,
  }) = _RoundedFillButton;

  const factory RoundedButton.border({
    Key? key,
    required String text,
    Color foregroundColor,
    BorderSide borderSide,
    void Function()? onPressed,
  }) = _RoundedBorderButton;

  final String text;
  final Size minimumSize;
  final EdgeInsets padding;
  final BorderSide? borderSide;
  final Color? foregroundColor;
  final Color? backgroundColor;
  final Color? disabledColor;
  final double opacity;
  final Color? overlay;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: Text(text),
      style: ButtonStyle(
        minimumSize: MaterialStateProperty.all<Size>(minimumSize),
        shape: MaterialStateProperty.all<OutlinedBorder>(
          const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(
                SupervielleConstants.radiusxs,
              ),
            ),
          ),
        ),
        textStyle: MaterialStateProperty.all<TextStyle>(SupervielleTextStyles.s.medium),
        foregroundColor: MaterialStateProperty.resolveWith<Color?>(
          (states) {
            if (states.contains(MaterialState.disabled)) {
              return SupervielleColors.grey700;
            }

            return foregroundColor;
          },
        ),
        side: MaterialStateProperty.resolveWith<BorderSide?>(
          (states) {
            if (states.contains(MaterialState.disabled)) {
              return borderSide?.copyWith(color: SupervielleColors.grey300);
            }

            return borderSide;
          },
        ),
        padding: MaterialStateProperty.all<EdgeInsets>(padding),
        backgroundColor: MaterialStateProperty.resolveWith<Color?>(
          (states) {
            if (states.contains(MaterialState.disabled)) {
              return disabledColor;
            }

            return backgroundColor?.withOpacity(opacity);
          },
        ),
        overlayColor: MaterialStateProperty.all<Color>(overlay ?? SupervielleColors.overlay),
      ),
      onPressed: onPressed,
    );
  }
}

class _RoundedTranslucentButton extends RoundedButton {
  const _RoundedTranslucentButton({
    Key? key,
    required String text,
    Color foregroundColor = SupervielleColors.grey900,
    Color backgroundColor = SupervielleColors.grey400,
    double opacity = 0.12,
    void Function()? onPressed,
  }) : super(
          key: key,
          text: text,
          foregroundColor: foregroundColor,
          backgroundColor: backgroundColor,
          opacity: opacity,
          onPressed: onPressed,
        );
}

class _RoundedFillButton extends RoundedButton {
  const _RoundedFillButton({
    Key? key,
    required String text,
    Color foregroundColor = SupervielleColors.white,
    Color backgroundColor = SupervielleColors.red900,
    Color disabledColor = SupervielleColors.grey300,
    Color overlay = SupervielleColors.red700,
    void Function()? onPressed,
  }) : super(
          key: key,
          text: text,
          foregroundColor: foregroundColor,
          backgroundColor: backgroundColor,
          disabledColor: disabledColor,
          overlay: overlay,
          onPressed: onPressed,
        );
}

class _RoundedBorderButton extends RoundedButton {
  const _RoundedBorderButton({
    Key? key,
    required String text,
    Color foregroundColor = SupervielleColors.grey900,
    BorderSide borderSide = const BorderSide(
      color: SupervielleColors.grey900,
    ),
    void Function()? onPressed,
  }) : super(
          key: key,
          text: text,
          foregroundColor: foregroundColor,
          borderSide: borderSide,
          onPressed: onPressed,
        );
}
