import 'package:easy_localization/easy_localization.dart';
import 'package:evently/providers/app_theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/language_provider.dart';
import '../theme/app_colors_extension.dart';
import '../util/text_styles.dart';

class ToggleLang extends StatefulWidget {
  final LanguageProvider languageProvider;

  const ToggleLang({super.key, required this.languageProvider});

  @override
  State<ToggleLang> createState() => _ToggleLangState();
}

class _ToggleLangState extends State<ToggleLang> {
  bool isSelected = true;

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
      child: Row(
        mainAxisSize: .min,
        children: [
          LanguageButton(
            text: "english".tr(),
            isActive: isSelected,
            onTap: () {
              languageProvider.changeToEnglish(context);
              isSelected = true;
            },
          ),
          SizedBox(width: 10),
          LanguageButton(
            text: "arabic".tr(),
            isActive: !isSelected,
            onTap: () {
              languageProvider.changeToArabic(context);
              isSelected = false;
            },
          ),
        ],
      ),
    );
  }
}

class LanguageButton extends StatelessWidget {
  final String text;
  final bool isActive;
  final void Function()? onTap;

  const LanguageButton({
    super.key,
    required this.text,
    this.isActive = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<AppThemeProvider>(context);

    final colors = Theme.of(context).extension<AppColorsExtension>()!;
    final bool isDark = themeProvider.isDark(context);

    Color bgColor = isActive
        ? colors.mainColor
        : (isDark ? colors.inputs : colors.white);

    Color textColor = isActive
        ? colors.white
        : (isDark ? colors.white : colors.mainColor);

    Color borderColor = isActive
        ? Colors.transparent
        : (isDark ? colors.stroke : Colors.transparent);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: borderColor),
        ),
        child: Text(
          text,
          style: TextStyles.inter14Medium.copyWith(color: textColor),
        ),
      ),
    );
  }
}
