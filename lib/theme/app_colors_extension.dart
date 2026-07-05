import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppColorsExtension extends ThemeExtension<AppColorsExtension> {
  final Color mainText;
  final Color mainColor;
  final Color image;
  final Color container;
  final Color background;
  final Color stroke;
  final Color secText;
  final Color disable;
  final Color white;
  final Color success;
  final Color warning;
  final Color red;
  final Color inputs;
  final Color indicator;

  AppColorsExtension({
    required this.mainText,
    required this.mainColor,
    required this.image,
    required this.container,
    required this.background,
    required this.stroke,
    required this.secText,
    required this.disable,
    required this.white,
    required this.success,
    required this.warning,
    required this.red,
    required this.inputs,
    required this.indicator,
  });

  @override
  ThemeExtension<AppColorsExtension> copyWith({
    Color? mainText,
    Color? mainColor,
    Color? image,
    Color? container,
    Color? background,
    Color? stroke,
    Color? secText,
    Color? disable,
    Color? white,
    Color? success,
    Color? warning,
    Color? red,
    Color? inputs,
    Color? indicator,
  }) {
    return AppColorsExtension(
      mainText: mainText ?? this.mainText,
      mainColor: mainColor ?? this.mainColor,
      image: image ?? this.image,
      container: container ?? this.container,
      background: background ?? this.background,
      stroke: stroke ?? this.stroke,
      secText: secText ?? this.secText,
      disable: disable ?? this.disable,
      white: white ?? this.white,
      success: success ?? this.success,
      warning: warning ?? this.warning,
      red: red ?? this.red,
      inputs: inputs ?? this.inputs,
      indicator: indicator ?? this.indicator,
    );
  }

  @override
  ThemeExtension<AppColorsExtension> lerp(
    ThemeExtension<AppColorsExtension>? other,
    double t,
  ) {
    if (other is! AppColorsExtension) return this;
    return AppColorsExtension(
      mainText: Color.lerp(mainText, other.mainText, t)!,
      mainColor: Color.lerp(mainColor, other.mainColor, t)!,
      image: Color.lerp(image, other.image, t)!,
      container: Color.lerp(container, other.container, t)!,
      background: Color.lerp(background, other.background, t)!,
      stroke: Color.lerp(stroke, other.stroke, t)!,
      secText: Color.lerp(secText, other.secText, t)!,
      disable: Color.lerp(disable, other.disable, t)!,
      white: Color.lerp(white, other.white, t)!,
      success: Color.lerp(success, other.success, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      red: Color.lerp(red, other.red, t)!,
      inputs: Color.lerp(inputs, other.inputs, t)!,
      indicator: Color.lerp(indicator, other.indicator, t)!,
    );
  }

  // Light Theme
  static final light = AppColorsExtension(
    mainText: AppColors.mainText,
    mainColor: AppColors.mainColor,
    image: AppColors.image,
    container: AppColors.container,
    background: AppColors.background,
    stroke: AppColors.stroke,
    secText: AppColors.secText,
    disable: AppColors.disable,
    white: AppColors.white,
    success: AppColors.success,
    warning: AppColors.warning,
    red: AppColors.red,
    inputs: AppColors.inputs,
    indicator: AppColors.indicator,
  );

  // Dark Theme
  static final dark = AppColorsExtension(
    mainText: AppColors.mainTextDark,
    mainColor: AppColors.mainColorDark,
    image: AppColors.imageDark,
    container: AppColors.containerDark,
    background: AppColors.backgroundDark,
    stroke: AppColors.strokeDark,
    secText: AppColors.secTextDark,
    disable: AppColors.disable,
    white: AppColors.white,
    success: AppColors.success,
    warning: AppColors.warning,
    red: AppColors.red,
    inputs: AppColors.inputs,
    indicator: AppColors.indicatorDark,
  );
}
