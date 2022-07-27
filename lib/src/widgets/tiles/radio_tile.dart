import 'package:flutter/material.dart';
import 'package:spv_theme/spv_theme.dart';


const double _size = 18.0;
const Duration _duration = Duration(milliseconds: 200);
const Curve _curve = Curves.easeOut;

class RadioTile extends StatelessWidget {
  const RadioTile({
    Key? key,
    required this.selected,
    required this.label,
    this.onChanged,
  }) : super(key: key);

  final bool selected;
  final String label;
  final void Function(bool)? onChanged;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: onChanged == null,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Row(
          children: [
            ActionButton.child(
              radius: 24.0,
              child: AnimatedContainer(
                duration: _duration,
                curve: _curve,
                width: _size,
                height: _size,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: SupervielleColors.white,
                  border: Border.all(
                    color: selected ? SupervielleColors.red900 : SupervielleColors.grey700,
                    width: selected ? 6.0 : 1.0,
                  ),
                ),
              ),
              onTap: () => onChanged?.call(!selected),
            ),
            const SizedBox(width: 8.0),
            Expanded(
              child: Text(
                label,
                overflow: TextOverflow.ellipsis,
                style: SupervielleTextStyles.s.regular.grey900,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
