import 'package:evently/theme/app_colors_extension.dart';
import 'package:flutter/material.dart';

class AppTextField {
  static InputDecoration textFieldStyle({
    required AppColorsExtension colors,
    required String hintText,
    required IconData? prefixIcon,
    required IconData? suffixIcon,
    void Function()? togglePassword,
  }) {
    return InputDecoration(
      hintText: hintText,

      filled: true,
      fillColor: colors.container,
      hintStyle: TextStyle(color: colors.secText, fontWeight: FontWeight.w400),
      labelStyle: TextStyle(color: colors.secText, fontWeight: FontWeight.w500),
      prefixIcon: prefixIcon != null
          ? Icon(prefixIcon, color: colors.disable)
          : null,
      suffixIcon: suffixIcon != null
          ? InkWell(
              onTap: togglePassword,
              child: Icon(suffixIcon, color: colors.disable),
            )
          : null,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: colors.stroke),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: colors.stroke),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: colors.red),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: colors.red),
      ),
    );
  }
}
