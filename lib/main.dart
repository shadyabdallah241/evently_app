import 'package:easy_localization/easy_localization.dart';
import 'package:evently/providers/app_theme_provider.dart';
import 'package:evently/providers/event_list_provider.dart';
import 'package:evently/providers/language_provider.dart';
import 'package:evently/screens/create_event_screen.dart';
import 'package:evently/screens/event_details_screen.dart';
import 'package:evently/screens/forget_password_screen.dart';
import 'package:evently/screens/home_screen.dart';
import 'package:evently/screens/intro_screen.dart';
import 'package:evently/screens/login_screen.dart';
import 'package:evently/screens/onboarding_screen.dart';
import 'package:evently/screens/register_screen.dart';
import 'package:evently/screens/splash_screen.dart';
import 'package:evently/theme/app_colors_extension.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await Hive.initFlutter();
  await Hive.openBox("settings");
  runApp(
    EasyLocalization(
      supportedLocales: [Locale("en"), Locale("ar")],
      path: "assets/translations",
      fallbackLocale: Locale("en"),
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) {
              return LanguageProvider();
            },
          ),
          ChangeNotifierProvider(
            create: (_) {
              return AppThemeProvider();
            },
          ),
          ChangeNotifierProvider(
            create: (_) {
              return EventListProvider();
            },
          ),
        ],
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<AppThemeProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,

      theme: ThemeData.light().copyWith(
        extensions: <ThemeExtension<dynamic>>[AppColorsExtension.light],
      ),
      darkTheme: ThemeData.dark().copyWith(
        extensions: <ThemeExtension<dynamic>>[AppColorsExtension.dark],
      ),
      themeMode: themeProvider.appTheme,
      initialRoute: SplashScreen.routeName,
      routes: {
        SplashScreen.routeName: (_) => SplashScreen(),
        OnboardingScreen.routeName: (_) => OnboardingScreen(),
        IntroScreen.routeName: (_) => IntroScreen(),
        RegisterScreen.routeName: (_) => RegisterScreen(),
        LoginScreen.routeName: (_) => LoginScreen(),
        ForgetPasswordScreen.routeName: (_) => ForgetPasswordScreen(),
        HomeScreen.routeName: (_) => HomeScreen(),
        CreateEventScreen.routeName: (_) => CreateEventScreen(),
        EventDetailsScreen.routeName: (_) => EventDetailsScreen(),
      },
    );
  }
}
