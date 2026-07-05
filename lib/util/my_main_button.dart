import 'package:evently/util/app_button_style.dart';
import 'package:flutter/material.dart';

import '../theme/app_colors_extension.dart';

class MyMainButton extends StatelessWidget {
  final AppColorsExtension colors;
  final String buttonText;
  final void Function()? onPressed;

  const MyMainButton({
    super.key,
    required this.colors,
    required this.buttonText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: AppButtonStyle.elevatedButtonStyle(colors),
      onPressed: onPressed,
      child: Text(buttonText),
    );
  }
}
