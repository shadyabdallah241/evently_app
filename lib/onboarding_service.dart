import 'package:hive/hive.dart';

class OnboardingService {
  static const String _boxName = 'settings';
  static const String _keySeenOnboarding = 'seen_onboarding';

  static Future<bool> hasSeenOnboarding() async {
    final box = Hive.box(_boxName);
    return box.get(_keySeenOnboarding, defaultValue: false) as bool;
  }

  static Future<void> setSeenOnboarding() async {
    final box = Hive.box(_boxName);
    await box.put(_keySeenOnboarding, true);
  }
}
