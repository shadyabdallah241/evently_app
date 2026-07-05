import 'package:evently/providers/app_theme_provider.dart';
import 'package:evently/theme/app_colors_extension.dart';
import 'package:evently/util/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Category extends StatelessWidget {
  final IconData categoryIcon;
  final String categoryText;
  final bool isSelected;
  final Color selectedBackgroundColor;
  final Color selectedTextColor;
  final Color unselectedBackgroundColor;
  final Color unselectedTextColor;

  const Category({
    super.key,
    required this.categoryIcon,
    required this.categoryText,
    required this.isSelected,
    required this.selectedBackgroundColor,
    required this.selectedTextColor,
    required this.unselectedBackgroundColor,
    required this.unselectedTextColor,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColorsExtension>()!;
    var themeProvider = Provider.of<AppThemeProvider>(context);
    final bool isDark = themeProvider.appTheme == ThemeMode.dark;
    Color backgroundColor = isSelected
        ? selectedBackgroundColor
        : unselectedBackgroundColor;
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(40),
        border: Border.all(width: 1, color: colors.stroke),
      ),
      child: Row(
        children: [
          Icon(
            categoryIcon,
            color: isSelected ? colors.white : colors.mainColor,
          ),
          SizedBox(width: 8),
          Text(
            categoryText,
            style: TextStyles.inter16Medium.copyWith(
              color: isSelected
                  ? (isDark ? colors.white : colors.white)
                  : (isDark ? colors.white : colors.mainText),
            ),
          ),
        ],
      ),
    );
  }
}
