import 'package:easy_localization/easy_localization.dart';
import 'package:evently/components/toggle_lang.dart';
import 'package:evently/screens/intro_screen.dart';
import 'package:evently/util/app_images_path.dart';
import 'package:evently/util/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../onboarding_service.dart';
import '../providers/app_theme_provider.dart';
import '../providers/language_provider.dart';
import '../theme/app_colors_extension.dart';
import '../util/my_main_button.dart';

class OnboardingScreen extends StatelessWidget {
  static const String routeName = "OnboardingScreen";

  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    final colors = Theme.of(context).extension<AppColorsExtension>()!;
    return SafeArea(
      child: Scaffold(
        backgroundColor: colors.background,
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: .start,
            children: [
              Align(
                alignment: .center,
                child: Image.asset(
                  AppImagesPath.logoH,
                  width: 150,
                  fit: .contain,
                ),
              ),
              SizedBox(height: 20),
              Image.asset(AppImagesPath.intro1, color: colors.image),
              SizedBox(height: 20),
              Text(
                "screen1_title".tr(),
                style: TextStyles.inter20Bold.copyWith(color: colors.mainText),
              ),
              SizedBox(height: 8),
              Text(
                "screen1_description".tr(),
                style: TextStyles.inter16Medium.copyWith(color: colors.secText),
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: .spaceBetween,

                children: [
                  Text(
                    "language".tr(),
                    style: TextStyles.inter16Bold.copyWith(color: colors.image),
                  ),

                  ToggleLang(languageProvider: languageProvider),
                ],
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: .spaceBetween,
                children: [
                  Text(
                    "theme_label".tr(),
                    style: TextStyles.inter16Bold.copyWith(color: colors.image),
                  ),
                  ToggleTheme(),
                ],
              ),
              SizedBox(height: 16),
              SizedBox(
                width: .infinity,
                child: MyMainButton(
                  colors: colors,
                  buttonText: "lets_start".tr(),
                  onPressed: () async {
                    Navigator.pushNamed(context, IntroScreen.routeName);
                    await OnboardingService.setSeenOnboarding();
                    Navigator.pushReplacementNamed(
                      context,
                      IntroScreen.routeName,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ToggleTheme extends StatefulWidget {
  const ToggleTheme({super.key});

  @override
  State<ToggleTheme> createState() => _ToggleThemeState();
}

class _ToggleThemeState extends State<ToggleTheme> {
  bool isSelected = true;

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<AppThemeProvider>(context);
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
      child: Row(
        children: [
          ThemeButton(
            icon: AppImagesPath.sun,
            isActive: isSelected,
            onTap: () {
              if (themeProvider.getThemeName() == "dark") {
                themeProvider.changeTheme(ThemeMode.light);
              } else {
                themeProvider.changeTheme(ThemeMode.dark);
              }
              setState(() {
                isSelected = true;
              });
            },
            currentTheme: themeProvider.appTheme,
          ),
          SizedBox(width: 20),
          ThemeButton(
            currentTheme: themeProvider.appTheme,
            icon: AppImagesPath.moon,
            isActive: !isSelected,
            onTap: () {
              if (themeProvider.getThemeName() == "light") {
                themeProvider.changeTheme(ThemeMode.dark);
              } else {
                themeProvider.changeTheme(ThemeMode.light);
              }
              setState(() {
                isSelected = false;
              });
            },
          ),
        ],
      ),
    );
  }
}

class ThemeButton extends StatelessWidget {
  final String icon;
  final bool isActive;
  final void Function()? onTap;
  final ThemeMode currentTheme;

  const ThemeButton({
    super.key,
    required this.icon,
    required this.isActive,
    this.onTap,
    required this.currentTheme,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColorsExtension>()!;
    final bool isDark = currentTheme == ThemeMode.dark;

    Color bgColor = isDark
        ? (isActive ? colors.mainColor : colors.container)
        : (isActive ? colors.mainColor : colors.white);

    Color iconColor = isDark
        ? colors.white
        : (isActive ? colors.white : colors.mainColor);

    Color strok = isDark
        ? (isActive ? Colors.transparent : colors.stroke)
        : (isActive ? Colors.transparent : Colors.white);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 4, horizontal: 16),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: strok),
        ),
        child: Image.asset(icon, width: 24, color: iconColor),
      ),
    );
  }
}
