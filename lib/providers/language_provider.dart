import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';

class LanguageProvider extends ChangeNotifier {
  Future<void> changeToEnglish(BuildContext context) async {
    await context.setLocale(Locale("en"));
    notifyListeners();
  }

  Future<void> changeToArabic(BuildContext context) async {
    await context.setLocale(Locale("ar"));
    notifyListeners();
  }

  bool isArabic(BuildContext context) {
    return context.locale.languageCode == "ar";
  }

  Future<void> togglelanguage(BuildContext context) async {
    if (context.locale.languageCode == "ar") {
      context.setLocale(Locale("en"));
    } else {
      context.setLocale(Locale("ar"));
    }
    notifyListeners();
  }
}
