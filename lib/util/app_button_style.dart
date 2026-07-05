import 'package:flutter/material.dart';

import '../theme/app_colors_extension.dart';

class AppButtonStyle {
  static ButtonStyle elevatedButtonStyle(AppColorsExtension colors) {
    return ElevatedButton.styleFrom(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      padding: const EdgeInsets.all(16),
      textStyle: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.5,
      ),
      foregroundColor: colors.white,
      backgroundColor: colors.mainColor,
    );
  }
}
