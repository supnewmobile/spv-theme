import 'package:flutter/material.dart';
import 'package:spv_theme/spv_theme.dart';

const double _draggerHeight = 4.0;

class BottomModalButton {
  const BottomModalButton({required this.text, required this.onPressed});

  final String text;
  final void Function() onPressed;
}

class BottomModal extends StatelessWidget {
  const BottomModal({
    Key? key,
    this.title,
    required this.sections,
    this.padding = const EdgeInsets.all(24.0),
    this.primaryButton,
    this.secondaryButton,
  }) : super(key: key);

  final String? title;
  final List<Widget> sections;
  final EdgeInsets padding;
  final BottomModalButton? primaryButton;
  final BottomModalButton? secondaryButton;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 8.0),
        const FractionallySizedBox(
          widthFactor: 0.25,
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(_draggerHeight * 0.5),
              ),
              color: SupervielleColors.grey200,
            ),
            child: SizedBox(height: _draggerHeight),
          ),
        ),
        SizedBox(height: padding.top),
        if (title != null) ...[
          Text(
            title!,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: SupervielleTextStyles.s.bold.grey900,
          ),
          const SizedBox(height: 8.0),
          const ThinDivider(height: 32.0),
        ],
        for (var section in sections) ...[
          Padding(
            padding: EdgeInsets.only(
              left: padding.left,
              right: padding.right,
            ),
            child: section,
          ),
          const ThinDivider(height: 32.0),
        ],
        Padding(
          padding: EdgeInsets.fromLTRB(
            padding.left,
            0.0,
            padding.right,
            padding.bottom,
          ),
          child: Column(
            children: [
              if (primaryButton != null)
                RoundedButton.fill(
                  text: primaryButton!.text,
                  onPressed: primaryButton!.onPressed,
                ),
              if (secondaryButton != null) ...[
                const SizedBox(height: 8.0),
                RoundedButton.translucent(
                  text: secondaryButton!.text,
                  onPressed: secondaryButton!.onPressed,
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
