import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../google_sign_in_service.dart';
import '../providers/app_theme_provider.dart';
import '../screens/home_screen.dart';
import '../theme/app_colors_extension.dart';
import '../util/app_images_path.dart';

class GoogleSignUpBtn extends StatelessWidget {
  final String text;

  const GoogleSignUpBtn({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColorsExtension>();
    var themeProvider = Provider.of<AppThemeProvider>(context);
    bool isDark = themeProvider.appTheme == ThemeMode.dark;
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: 12),
        backgroundColor: colors?.container,
        elevation: 0,
      ),
      onPressed: () {
        GoogleAuthServices.signInWithGoogle();
        Navigator.pushNamed(context, HomeScreen.routeName);
      },
      child: Row(
        spacing: 8,
        mainAxisAlignment: .center,
        children: [
          Image.asset(AppImagesPath.googleLogo, width: 24),
          Text(
            text,
            style: TextStyle(
              color: isDark ? colors?.white : colors?.mainColor,
              fontSize: 18,
              fontWeight: .w500,
            ),
          ),
        ],
      ),
    );
  }
}
