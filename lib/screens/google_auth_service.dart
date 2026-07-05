import 'package:evently/onboarding_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'home_screen.dart';
import 'login_screen.dart';
import 'onboarding_screen.dart';

class AuthService {
  static Future<String> getInitialRoute() async {
    final seen = await OnboardingService.hasSeenOnboarding();
    if (!seen) {
      return OnboardingScreen.routeName;
    }

    final user = await FirebaseAuth.instance.authStateChanges().first;

    if (user != null) {
      return HomeScreen.routeName;
    }
    return LoginScreen.routeName;
  }
}
