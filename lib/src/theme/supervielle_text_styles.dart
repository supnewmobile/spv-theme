import 'package:flutter/painting.dart' show TextStyle, FontWeight;

import './supervielle_colors.dart';

class SupervielleTextStyles {
  static const String _fontFamily = 'Inter';
  static const String _package = 'spv_theme';

  static const TextStyle xxxs = TextStyle(
    fontFamily: _fontFamily,
    package: _package,
    fontSize: 10.0,
    letterSpacing: 0.1,
    height: 1.6,
  );

  static const TextStyle xxs = TextStyle(
    fontFamily: _fontFamily,
    package: _package,
    fontSize: 12.0,
    letterSpacing: 0.1,
    height: 1.3,
  );

  static const TextStyle xs = TextStyle(
    fontFamily: _fontFamily,  
    package: _package,
    fontSize: 14.0,
    letterSpacing: 0.1,
    height: 1.4,
  );

  static const TextStyle s = TextStyle(
    fontFamily: _fontFamily,  
    package: _package,
    fontSize: 16.0,
    height: 1.5,
  );

  static const TextStyle m = TextStyle(
    fontFamily: _fontFamily,  
    package: _package,
    fontSize: 20.0,
    height: 1.5,
  );

  static const TextStyle l = TextStyle(
    fontFamily: _fontFamily,
    package: _package,
    fontSize: 24.0,
    height: 1.3,
  );

  static const TextStyle xl = TextStyle(
    fontFamily: _fontFamily,  
    package: _package,
    fontSize: 32.0,
    letterSpacing: -0.5,
    height: 1.4,
  );

  static const TextStyle xxl = TextStyle(
    fontFamily: _fontFamily,  
    package: _package,
    fontSize: 40.0,
    letterSpacing: -0.5,
    height: 1.2,
  );
}

extension SupervielleTextStyleExtension on TextStyle {
  TextStyle get regular => copyWith(fontWeight: FontWeight.w400);
  TextStyle get medium => copyWith(fontWeight: FontWeight.w500);
  TextStyle get semibold => copyWith(fontWeight: FontWeight.w600);
  TextStyle get bold => copyWith(fontWeight: FontWeight.w700);

  TextStyle get white => apply(color: SupervielleColors.white);
  TextStyle get black => apply(color: SupervielleColors.black);

  TextStyle get red100 => apply(color: SupervielleColors.red100);
  TextStyle get red200 => apply(color: SupervielleColors.red200);
  TextStyle get red500 => apply(color: SupervielleColors.red500);
  TextStyle get red700 => apply(color: SupervielleColors.red700);
  TextStyle get red900 => apply(color: SupervielleColors.red900);

  TextStyle get purple100 => apply(color: SupervielleColors.purple100);
  TextStyle get purple200 => apply(color: SupervielleColors.purple200);
  TextStyle get purple500 => apply(color: SupervielleColors.purple500);
  TextStyle get purple700 => apply(color: SupervielleColors.purple700);
  TextStyle get purple900 => apply(color: SupervielleColors.purple900);

  TextStyle get green100 => apply(color: SupervielleColors.green100);
  TextStyle get green200 => apply(color: SupervielleColors.green200);
  TextStyle get green500 => apply(color: SupervielleColors.green500);
  TextStyle get green700 => apply(color: SupervielleColors.green700);
  TextStyle get green900 => apply(color: SupervielleColors.green900);

  TextStyle get orange100 => apply(color: SupervielleColors.orange100);
  TextStyle get orange200 => apply(color: SupervielleColors.orange200);
  TextStyle get orange500 => apply(color: SupervielleColors.orange500);
  TextStyle get orange700 => apply(color: SupervielleColors.orange700);
  TextStyle get orange900 => apply(color: SupervielleColors.orange900);

  TextStyle get yellow100 => apply(color: SupervielleColors.yellow100);
  TextStyle get yellow200 => apply(color: SupervielleColors.yellow200);
  TextStyle get yellow500 => apply(color: SupervielleColors.yellow500);
  TextStyle get yellow700 => apply(color: SupervielleColors.yellow700);
  TextStyle get yellow900 => apply(color: SupervielleColors.yellow900);

  TextStyle get grey100 => apply(color: SupervielleColors.grey100);
  TextStyle get grey200 => apply(color: SupervielleColors.grey200);
  TextStyle get grey300 => apply(color: SupervielleColors.grey300);
  TextStyle get grey400 => apply(color: SupervielleColors.grey400);
  TextStyle get grey700 => apply(color: SupervielleColors.grey700);
  TextStyle get grey800 => apply(color: SupervielleColors.grey800);
  TextStyle get grey900 => apply(color: SupervielleColors.grey900);
}
