import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:evently/components/google_signup_btn.dart';
import 'package:evently/screens/home_screen.dart';
import 'package:evently/util/app_images_path.dart';
import 'package:evently/validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../theme/app_colors_extension.dart';
import '../util/app_button_style.dart';
import '../util/app_text_field.dart';
import '../util/text_styles.dart';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = "RegisterScreen";

  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final ValueNotifier<bool> isPasswordObscured = ValueNotifier<bool>(false);

  final ValueNotifier<bool> isConfirmPasswordObscured = ValueNotifier<bool>(
    false,
  );

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  Future signUp() async {
    if (passwordConfirmed()) {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
              email: _emailController.text.trim(),
              password: _passwordController.text.trim(),
            );
        await adduserDetails(
          uid: userCredential.user!.uid,
          userName: _nameController.text.trim(),
          email: _emailController.text.trim(),
        );
        if (mounted) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            HomeScreen.routeName,
            (rout) => false,
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Registration failed: ${e.toString()}")),
        );
      }
    }
  }

  bool passwordConfirmed() {
    if (_confirmPasswordController.text.trim() ==
        _passwordController.text.trim()) {
      return true;
    } else {
      return false;
    }
  }

  Future adduserDetails({
    required String uid,
    required String userName,
    required String email,
  }) async {
    await FirebaseFirestore.instance.collection("users").doc(uid).set({
      "user name": _nameController.text.trim(),
      "email": _emailController.text.trim(),
    });
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColorsExtension>()!;
    return SafeArea(
      child: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Scaffold(
          backgroundColor: colors.background,
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  spacing: 20,
                  children: [
                    Center(child: Image.asset(AppImagesPath.logoH, width: 145)),
                    SizedBox(height: 8),
                    Align(
                      alignment: .centerLeft,
                      child: Text(
                        "Create your account",
                        style: TextStyles.inter24Bold.copyWith(
                          color: colors.image,
                        ),
                      ),
                    ),
                    TextFormField(
                      controller: _nameController,
                      validator: Validator.validateName,
                      decoration: AppTextField.textFieldStyle(
                        colors: colors,
                        hintText: "name_placeholder".tr(),
                        prefixIcon: Icons.person_outline,
                        suffixIcon: null,
                      ),
                    ),
                    TextFormField(
                      controller: _emailController,
                      validator: Validator.validateEmail,
                      decoration: AppTextField.textFieldStyle(
                        colors: colors,
                        hintText: "email_placeholder".tr(),
                        prefixIcon: Icons.email_outlined,
                        suffixIcon: null,
                      ),
                    ),
                    ValueListenableBuilder(
                      valueListenable: isPasswordObscured,
                      builder: (context, isObscured, child) {
                        return TextFormField(
                          controller: _passwordController,
                          obscureText: isObscured,
                          validator: Validator.validatePassword,
                          decoration: AppTextField.textFieldStyle(
                            colors: colors,
                            togglePassword: () {
                              isPasswordObscured.value =
                                  !isPasswordObscured.value;
                            },
                            hintText: "password_placeholder".tr(),
                            prefixIcon: Icons.lock_outline,
                            suffixIcon: isObscured
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                        );
                      },
                    ),
                    ValueListenableBuilder(
                      valueListenable: isConfirmPasswordObscured,
                      builder: (context, isObscured, child) {
                        return TextFormField(
                          controller: _confirmPasswordController,
                          obscureText: isConfirmPasswordObscured.value,
                          validator: (value) {
                            return Validator.confirmPassword(
                              _passwordController.text,
                            )(value);
                          },
                          decoration: AppTextField.textFieldStyle(
                            togglePassword: () {
                              isConfirmPasswordObscured.value =
                                  !isConfirmPasswordObscured.value;
                            },
                            colors: colors,
                            hintText: "re_password_placeholder".tr(),
                            prefixIcon: Icons.lock_outline,
                            suffixIcon: isObscured
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 10),
                    SizedBox(
                      width: .infinity,
                      child: ElevatedButton(
                        style: AppButtonStyle.elevatedButtonStyle(colors),
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            await signUp();
                          }
                        },
                        child: Text("button_text".tr()),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: .center,
                      children: [
                        Text(
                          "footer_text".tr(),
                          style: TextStyles.inter14Medium.copyWith(
                            color: colors.secText,
                            fontWeight: .w200,
                          ),
                        ),
                        TextButton(
                          style: TextButton.styleFrom(padding: EdgeInsets.zero),
                          onPressed: () {
                            Navigator.pushReplacementNamed(
                              context,
                              LoginScreen.routeName,
                            );
                          },
                          child: Text(
                            "login_link".tr(),
                            style: TextStyle(
                              decoration: .underline,
                              decorationColor: colors.mainColor,
                              decorationThickness: 1,
                              color: colors.mainColor,
                              fontWeight: .bold,
                              fontSize: 14,
                              height: 1.5,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      spacing: 8,
                      mainAxisAlignment: .center,
                      children: [
                        Container(width: 150, height: 2, color: colors.stroke),
                        Text(
                          "or".tr(),
                          style: TextStyles.inter16Medium.copyWith(
                            color: colors.mainColor,
                          ),
                        ),
                        Container(width: 150, height: 2, color: colors.stroke),
                      ],
                    ),
                    GoogleSignUpBtn(text: "sign_up_with_google".tr()),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
