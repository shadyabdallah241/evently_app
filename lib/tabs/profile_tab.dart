import 'package:easy_localization/easy_localization.dart';
import 'package:evently/firebase_functions.dart';
import 'package:evently/screens/login_screen.dart';
import 'package:evently/util/app_images_path.dart';
import 'package:evently/util/dialog.dart';
import 'package:evently/util/text_styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/app_theme_provider.dart';
import '../providers/language_provider.dart';
import '../theme/app_colors_extension.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  String selectedlanguage = "en";

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    var themeProvider = Provider.of<AppThemeProvider>(context);
    bool isDark = themeProvider.appTheme == ThemeMode.dark;
    bool isArabic = languageProvider.isArabic(context);
    final colors = Theme.of(context).extension<AppColorsExtension>()!;
    final user = FirebaseAuth.instance.currentUser;
    final userImage = user?.photoURL;
    return SafeArea(
      child: Scaffold(
        backgroundColor: colors.background,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                ClipOval(
                  child: userImage != null
                      ? Image.network(
                          userImage,
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        )
                      : Image.asset(
                          AppImagesPath.logo,
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                ),
                SizedBox(height: 20),
                FutureBuilder(
                  future: FirebaseFunctions.getUserData(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator(color: colors.mainColor);
                    }
                    if (snapshot.hasData && snapshot.data != null) {
                      var userData = snapshot.data!;

                      return Column(
                        children: [
                          Text(
                            "${userData["user name"]}",
                            style: TextStyles.inter20Bold.copyWith(
                              color: colors.mainText,
                            ),
                          ),
                          Text(
                            "${userData["email"]}",
                            style: TextStyles.inter16Medium.copyWith(
                              color: colors.secText,
                            ),
                          ),
                        ],
                      );
                    }
                    return SizedBox.shrink();
                  },
                ),

                SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: colors.container,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: colors.stroke),
                  ),
                  width: .infinity,
                  child: Row(
                    mainAxisAlignment: .spaceBetween,
                    children: [
                      Text(
                        "dark_mode".tr(),
                        style: TextStyles.inter16Medium.copyWith(
                          color: colors.mainText,
                        ),
                      ),
                      InkWell(
                        focusColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () {
                          if (themeProvider.getThemeName() == "dark") {
                            themeProvider.changeTheme(ThemeMode.light);
                          } else {
                            themeProvider.changeTheme(ThemeMode.dark);
                          }

                          isDark = !isDark;
                        },
                        child: Stack(
                          alignment: isDark
                              ? (isArabic
                                    ? Alignment.centerLeft
                                    : Alignment.centerRight)
                              : (isArabic
                                    ? Alignment.centerRight
                                    : Alignment.centerLeft),
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: isDark
                                    ? colors.mainColor
                                    : colors.indicator,
                              ),
                              width: 36,
                              height: 20,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 2,
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.white,
                                ),
                                width: 16,
                                height: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16),
                ProfileButton(
                  text: 'language'.tr(),
                  icon: languageProvider.isArabic(context)
                      ? Icons.keyboard_arrow_left
                      : Icons.keyboard_arrow_right,
                  iconColor: colors.mainColor,
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return ShowModalSheet();
                      },
                    );
                  },
                ),
                SizedBox(height: 16),
                ProfileButton(
                  onTap: () {
                    MyDialogs.showMessage(
                      context: context,
                      message: "Are you sure you want to log out? Yes or No?",
                      buttonsCount: 2,
                      firstButtonText: "Yes",
                      firstButtonOnPressed: () async {
                        await FirebaseAuth.instance.signOut();
                        Navigator.pushNamed(context, LoginScreen.routeName);
                      },
                      secondButtonText: "No",
                      secondButtonOnPressed: () {
                        Navigator.pop(context);
                      },
                      title: "Logout",
                    );
                  },
                  text: 'logout'.tr(),
                  icon: Icons.logout,
                  iconColor: colors.red,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ShowModalSheet extends StatelessWidget {
  const ShowModalSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColorsExtension>()!;
    final languageProvider = Provider.of<LanguageProvider>(context);

    return SizedBox(
      height: 400,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          spacing: 24,
          crossAxisAlignment: .start,
          children: [
            Row(
              spacing: 10,
              children: [
                InkWell(
                  focusColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      border: Border.all(color: colors.red),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Icon(Icons.close),
                  ),
                ),
                Text("language".tr(), style: TextStyles.inter20Medium),
              ],
            ),
            InkWell(
              focusColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () {
                languageProvider.changeToEnglish(context);
              },
              child: SizedBox(width: .infinity, child: Text("English")),
            ),
            InkWell(
              focusColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () {
                languageProvider.changeToArabic(context);
              },
              child: SizedBox(width: .infinity, child: Text("اللغة العربية")),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final Color iconColor;
  final void Function()? onTap;

  const ProfileButton({
    super.key,
    required this.text,
    required this.icon,
    required this.iconColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColorsExtension>()!;

    return InkWell(
      onTap: onTap,
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: colors.container,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: colors.stroke),
          ),
          width: .infinity,
          child: Row(
            mainAxisAlignment: .spaceBetween,
            children: [
              Text(text, style: TextStyles.inter16Medium),
              Icon(icon, size: 30, color: iconColor),
            ],
          ),
        ),
      ),
    );
  }
}
