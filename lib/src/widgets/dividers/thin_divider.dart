import 'package:flutter/material.dart';

import '../../theme/theme.dart';

class ThinDivider extends Divider {
  const ThinDivider({
    Key? key,
    double height = 1.0,
    double indent = 0.0,
    double endIndent = 0.0,
  }) : super(
          key: key,
          height: height,
          color: SupervielleColors.grey200,
          thickness: 1.0,
          indent: indent,
          endIndent: endIndent,
        );
}

class ThinVerticalDivider extends VerticalDivider {
  const ThinVerticalDivider({
    Key? key,
    double width = 1.0,
    double indent = 0.0,
    double endIndent = 0.0,
  }) : super(
          key: key,
          width: width,
          color: SupervielleColors.grey200,
          thickness: 1.0,
          indent: indent,
          endIndent: endIndent,
        );
}
