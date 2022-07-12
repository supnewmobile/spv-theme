import 'package:flutter/material.dart';

import './supervielle_colors.dart';

class SupervielleConstants {
  // Los sizes no se incluyen aca porque es poco practico. Lo que si
  // respetar la regla del multiplo de 8: 2, 4, 8, 16, 24, 32 ...

  static const double radiusxxs = 4.0;
  static const double radiusxs = 8.0;
  static const double radiussm = 16.0;

  static const double viewPadding = 24;

  static const BoxShadow boxShadow = BoxShadow(offset: Offset(0.0, 4.0), blurRadius: 16.0);
}

extension SupervielleBoxShadowExtension on BoxShadow {
  BoxShadow get white => copyWith(color: SupervielleColors.white.withOpacity(0.5));
  BoxShadow get black => copyWith(color: SupervielleColors.black.withOpacity(0.5));

  BoxShadow get red100 => copyWith(color: SupervielleColors.red100.withOpacity(0.5));
  BoxShadow get red200 => copyWith(color: SupervielleColors.red200.withOpacity(0.5));
  BoxShadow get red500 => copyWith(color: SupervielleColors.red500.withOpacity(0.5));
  BoxShadow get red700 => copyWith(color: SupervielleColors.red700.withOpacity(0.5));
  BoxShadow get red900 => copyWith(color: SupervielleColors.red900.withOpacity(0.5));

  BoxShadow get purple100 => copyWith(color: SupervielleColors.purple100.withOpacity(0.5));
  BoxShadow get purple200 => copyWith(color: SupervielleColors.purple200.withOpacity(0.5));
  BoxShadow get purple500 => copyWith(color: SupervielleColors.purple500.withOpacity(0.5));
  BoxShadow get purple700 => copyWith(color: SupervielleColors.purple700.withOpacity(0.5));
  BoxShadow get purple900 => copyWith(color: SupervielleColors.purple900.withOpacity(0.5));

  BoxShadow get green100 => copyWith(color: SupervielleColors.green100.withOpacity(0.5));
  BoxShadow get green200 => copyWith(color: SupervielleColors.green200.withOpacity(0.5));
  BoxShadow get green500 => copyWith(color: SupervielleColors.green500.withOpacity(0.5));
  BoxShadow get green700 => copyWith(color: SupervielleColors.green700.withOpacity(0.5));
  BoxShadow get green900 => copyWith(color: SupervielleColors.green900.withOpacity(0.5));

  BoxShadow get orange100 => copyWith(color: SupervielleColors.orange100.withOpacity(0.5));
  BoxShadow get orange200 => copyWith(color: SupervielleColors.orange200.withOpacity(0.5));
  BoxShadow get orange500 => copyWith(color: SupervielleColors.orange500.withOpacity(0.5));
  BoxShadow get orange700 => copyWith(color: SupervielleColors.orange700.withOpacity(0.5));
  BoxShadow get orange900 => copyWith(color: SupervielleColors.orange900.withOpacity(0.5));

  BoxShadow get yellow100 => copyWith(color: SupervielleColors.yellow100.withOpacity(0.5));
  BoxShadow get yellow200 => copyWith(color: SupervielleColors.yellow200.withOpacity(0.5));
  BoxShadow get yellow500 => copyWith(color: SupervielleColors.yellow500.withOpacity(0.5));
  BoxShadow get yellow700 => copyWith(color: SupervielleColors.yellow700.withOpacity(0.5));
  BoxShadow get yellow900 => copyWith(color: SupervielleColors.yellow900.withOpacity(0.5));

  BoxShadow get grey100 => copyWith(color: SupervielleColors.grey100.withOpacity(0.5));
  BoxShadow get grey200 => copyWith(color: SupervielleColors.grey200.withOpacity(0.5));
  BoxShadow get grey300 => copyWith(color: SupervielleColors.grey300.withOpacity(0.5));
  BoxShadow get grey400 => copyWith(color: SupervielleColors.grey400.withOpacity(0.5));
  BoxShadow get grey700 => copyWith(color: SupervielleColors.grey700.withOpacity(0.5));
  BoxShadow get grey800 => copyWith(color: SupervielleColors.grey800.withOpacity(0.5));
  BoxShadow get grey900 => copyWith(color: SupervielleColors.grey900.withOpacity(0.5));

  BoxShadow copyWith({
    Color? color,
    Offset? offset,
    double? blurRadius,
    double? spreadRadius,
  }) =>
      BoxShadow(
        color: color ?? this.color,
        offset: offset ?? this.offset,
        blurRadius: blurRadius ?? this.blurRadius,
        spreadRadius: spreadRadius ?? this.spreadRadius,
      );
}
