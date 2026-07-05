import 'package:easy_localization/easy_localization.dart';

class Validator {
  Validator._();

  static String? validateEventTitle(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "enter_event_title".tr();
    }
    return null;
  }

  static String? validateEventDescription(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "enter_event_description".tr();
    }
    return null;
  }

  static String? validateEmail(String? value) {
    final trimmedValue = value?.trim() ?? "";
    if (trimmedValue.isEmpty) {
      return "email".tr();
    }
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    if (!emailRegex.hasMatch(trimmedValue)) {
      return 'email_validation_error'.tr();
    }
    return null;
  }

  static String? validateName(String? value) {
    if (value!.trim().isEmpty) {
      return "enter_name".tr();
    }
    final nameRegex = RegExp(r"^[a-zA-Z\s]+$");

    if (!nameRegex.hasMatch(value)) {
      return "name_validation_error".tr();
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "enter_password".tr();
    }
    final passwordRegex = RegExp(r'^.{8,}$');
    if (!passwordRegex.hasMatch(value)) {
      return "password_requirements".tr();
    }
    return null;
  }

  static String? Function(String?) confirmPassword(String? password) {
    return (String? value) {
      if (value == null || value.trim().isEmpty) {
        return "confirm_password".tr();
      }
      if (value != password) {
        return "password_mismatch".tr();
      }
      return null;
    };
  }
}
