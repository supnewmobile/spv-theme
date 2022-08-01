import 'package:flutter/material.dart';

import '../../theme/theme.dart';
import '../buttons/rounded_button.dart';
import '../dividers/thin_divider.dart';

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
    final hasPrimaryButton = primaryButton != null;
    final hasSecondaryButton = secondaryButton != null;

    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: FractionallySizedBox(
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
          ),
          if (title != null) ...[
            const SizedBox(height: 16.0),
            Text(
              title!,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: SupervielleTextStyles.s.bold.grey900,
            ),
            const SizedBox(height: 24.0),
            const ThinDivider(),
          ],
          Flexible(
            child: SingleChildScrollView(
              padding: padding,
              child: Column(
                children: [
                  for (var i = 0; i < sections.length; i++) ...[
                    sections[i],
                    if (i < sections.length - 1) const ThinDivider(height: 32.0),
                  ],
                ],
              ),
            ),
          ),
          if (hasPrimaryButton || hasSecondaryButton) ...[
            const ThinDivider(),
            const SizedBox(height: 24.0),
            Padding(
              padding: const EdgeInsets.fromLTRB(24.0, 0.0, 24.0, 24.0),
              child: Column(
                children: [
                  if (hasPrimaryButton)
                    RoundedButton.fill(
                      text: primaryButton!.text,
                      onPressed: primaryButton!.onPressed,
                    ),
                  if (hasSecondaryButton) ...[
                    if (hasPrimaryButton) const SizedBox(height: 8.0),
                    RoundedButton.translucent(
                      text: secondaryButton!.text,
                      onPressed: secondaryButton!.onPressed,
                    ),
                  ],
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
