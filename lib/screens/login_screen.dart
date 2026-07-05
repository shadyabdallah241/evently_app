import 'package:easy_localization/easy_localization.dart';
import 'package:evently/screens/home_screen.dart';
import 'package:evently/screens/register_screen.dart';
import 'package:evently/util/app_button_style.dart';
import 'package:evently/util/app_images_path.dart';
import 'package:evently/util/app_text_field.dart';
import 'package:evently/validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/google_signup_btn.dart';
import '../providers/language_provider.dart';
import '../theme/app_colors_extension.dart';
import '../util/text_styles.dart';
import 'forget_password_screen.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = "LoginScreen";

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final user = FirebaseAuth.instance.currentUser;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future signIn() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      if (user != null) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          HomeScreen.routeName,
          (route) => false,
        );
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  bool isPasswordVisable = false;

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    final colors = Theme.of(context).extension<AppColorsExtension>()!;
    return SafeArea(
      child: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: colors.background,
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: formKey,
                child: Column(
                  spacing: 16,
                  children: [
                    SizedBox(height: 12),
                    Image.asset(AppImagesPath.logoH, width: 145),
                    SizedBox(height: 12),
                    Align(
                      alignment: languageProvider.isArabic(context)
                          ? .centerRight
                          : .centerLeft,
                      child: Text(
                        "login_header".tr(),
                        style: TextStyles.inter24Bold.copyWith(
                          color: colors.image,
                        ),
                      ),
                    ),
                    TextFormField(
                      controller: _emailController,
                      validator: Validator.validateEmail,
                      decoration: AppTextField.textFieldStyle(
                        colors: colors,
                        hintText: "email".tr(),
                        prefixIcon: Icons.mail_outline,
                        suffixIcon: null,
                      ),
                    ),
                    TextFormField(
                      obscureText: isPasswordVisable,
                      controller: _passwordController,
                      validator: Validator.validatePassword,
                      decoration: AppTextField.textFieldStyle(
                        colors: colors,
                        hintText: "password".tr(),
                        prefixIcon: Icons.lock_outline,
                        togglePassword: () {
                          setState(() {
                            isPasswordVisable = !isPasswordVisable;
                          });
                        },
                        suffixIcon: isPasswordVisable
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                    ),
                    Align(
                      alignment: context.locale.languageCode == "en"
                          ? .topRight
                          : .topLeft,
                      child: TextButton(
                        style: TextButton.styleFrom(padding: EdgeInsets.zero),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return ForgetPasswordScreen();
                              },
                            ),
                          );
                        },
                        child: Text(
                          "forget_password".tr(),
                          style: TextStyles.inter14Bold.copyWith(
                            decoration: .underline,
                            decorationColor: colors.mainColor,
                            decorationThickness: 1,
                            color: colors.mainColor,
                            height: 1.5,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: .infinity,
                      child: ElevatedButton(
                        style: AppButtonStyle.elevatedButtonStyle(colors),
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            await signIn();
                          }
                        },
                        child: Text(
                          "login".tr(),
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: .center,
                      children: [
                        Text(
                          "dont_have_account".tr(),
                          style: TextStyles.inter14Medium.copyWith(
                            color: colors.secText,
                            fontWeight: .w200,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return RegisterScreen();
                                },
                              ),
                            );
                          },
                          child: Text(
                            "create_account".tr(),
                            style: TextStyles.inter14Bold.copyWith(
                              color: colors.mainColor,
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
                    SizedBox(height: 12),
                    GoogleSignUpBtn(text: "login_with_google".tr()),
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
