import 'package:easy_localization/easy_localization.dart';
import 'package:evently/util/app_images_path.dart';
import 'package:evently/util/app_text_field.dart';
import 'package:evently/util/my_main_button.dart';
import 'package:evently/validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../theme/app_colors_extension.dart';

class ForgetPasswordScreen extends StatefulWidget {
  static const String routeName = "ForgetPasswordScreen";

  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  dispose() {
    emailController.dispose();
    super.dispose();
  }

  Future resetPassword() async {
    try {
      if (formKey.currentState!.validate()) {
        await FirebaseAuth.instance.sendPasswordResetEmail(
          email: emailController.text.trim(),
        );
      }
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColorsExtension>()!;
    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back_ios, color: colors.image),
        ),
        title: Text(
          "reset_password_title".tr(),
          style: TextStyle(fontSize: 20),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Image.asset(
                  AppImagesPath.changeSetting,
                  fit: .contain,
                  color: colors.image,
                ),
                TextFormField(
                  controller: emailController,
                  validator: Validator.validateEmail,
                  decoration: AppTextField.textFieldStyle(
                    colors: colors,
                    hintText: "email_placeholder".tr(),
                    prefixIcon: Icons.email_outlined,
                    suffixIcon: null,
                  ),
                ),
                SizedBox(height: 28),
                SizedBox(
                  width: .infinity,
                  child: MyMainButton(
                    colors: colors,
                    buttonText: "reset_password_button".tr(),
                    onPressed: resetPassword,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
