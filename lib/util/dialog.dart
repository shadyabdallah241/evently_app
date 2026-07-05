import 'package:evently/util/text_styles.dart';
import 'package:flutter/material.dart';

import '../theme/app_colors_extension.dart';

class MyDialogs {
  static void showLoading({
    required BuildContext context,
    required String loadingMessage,
  }) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        final colors = Theme.of(dialogContext).extension<AppColorsExtension>()!;
        return AlertDialog(
          content: Column(
            spacing: 24,
            mainAxisSize: .min,
            children: [
              Text(
                loadingMessage,
                style: TextStyles.inter14Bold.copyWith(color: colors.mainColor),
              ),
              Center(child: CircularProgressIndicator(color: colors.mainColor)),
            ],
          ),
        );
      },
    );
  }

  static void showMessage({
    required BuildContext context,
    required String message,
    required int buttonsCount,
    String? firstButtonText,
    String? secondButtonText,
    void Function()? firstButtonOnPressed,
    void Function()? secondButtonOnPressed,
    String title = "",
  }) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        final colors = Theme.of(dialogContext).extension<AppColorsExtension>()!;

        Widget buildButtons() {
          if (buttonsCount == 0) {
            return Container();
          } else if (buttonsCount == 1) {
            return TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
                firstButtonOnPressed?.call();
              },
              child: Text(
                firstButtonText ?? "",
                style: TextStyles.inter14Bold.copyWith(color: colors.mainColor),
              ),
            );
          } else {
            return Row(
              mainAxisSize: .min,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(dialogContext);
                    secondButtonOnPressed?.call();
                  },
                  child: Text(
                    secondButtonText ?? "",
                    style: TextStyles.inter14Bold.copyWith(
                      color: colors.mainColor,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(dialogContext);
                    firstButtonOnPressed?.call();
                  },
                  child: Text(
                    firstButtonText ?? "",
                    style: TextStyles.inter14Bold.copyWith(
                      color: colors.mainColor,
                    ),
                  ),
                ),
              ],
            );
          }
        }

        return AlertDialog(
          content: Text(
            message,
            style: TextStyles.inter14Bold.copyWith(color: colors.secText),
          ),
          title: Text(
            title,
            style: TextStyles.inter14Bold.copyWith(color: colors.mainColor),
          ),
          actions: [buildButtons()],
        );
      },
    );
  }
}
