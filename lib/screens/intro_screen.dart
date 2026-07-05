import 'package:easy_localization/easy_localization.dart';
import 'package:evently/models/intro_model.dart';
import 'package:evently/screens/onboarding_screen.dart';
import 'package:evently/util/app_images_path.dart';
import 'package:flutter/material.dart';

import '../theme/app_colors_extension.dart';
import '../util/my_main_button.dart';
import '../util/text_styles.dart';
import 'login_screen.dart';

class IntroScreen extends StatefulWidget {
  static const routeName = "IntroScreen";

  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  PageController pageController = PageController();
  int currentSelected = 0;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColorsExtension>();

    if (colors == null) {
      return const Scaffold(
        body: Center(child: Text("Theme Extension Missing!")),
      );
    }
    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: GestureDetector(
          onTap: () {
            pageController.previousPage(
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          },
          child: Visibility(
            visible: currentSelected == 0 ? false : true,
            child: Icon(Icons.arrow_back_ios),
          ),
        ),
        title: Image.asset(
          AppImagesPath.logoH,
          width: 110,
          color: colors.image,
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Visibility(
              visible: currentSelected < intros.length - 1 ? true : false,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: colors.container,
                  border: Border.all(color: colors.stroke),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 6,
                ),
                child: GestureDetector(
                  onTap: () =>
                      Navigator.pushNamed(context, OnboardingScreen.routeName),
                  child: Text(
                    "skip".tr(),
                    style: TextStyles.inter14Bold.copyWith(color: colors.image),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: pageController,
                scrollDirection: .horizontal,
                itemCount: intros.length,
                onPageChanged: (index) {
                  setState(() {
                    currentSelected = index;
                  });
                },
                itemBuilder: (context, index) {
                  final IntroModel introModel = intros[index];
                  return Column(
                    mainAxisAlignment: .spaceEvenly,
                    crossAxisAlignment: .start,
                    children: [
                      Image.asset(introModel.introImage, color: colors.image),
                      Row(
                        spacing: 6,
                        mainAxisAlignment: .center,
                        children: [
                          AnimatedContainer(
                            duration: Duration(milliseconds: 300),
                            width: currentSelected == 0 ? 20 : 8,
                            height: 8,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: currentSelected == 0
                                  ? colors.mainColor
                                  : colors.indicator,
                            ),
                          ),
                          AnimatedContainer(
                            duration: Duration(milliseconds: 300),

                            width: currentSelected == 1 ? 20 : 8,
                            height: 8,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: currentSelected == 1
                                  ? colors.mainColor
                                  : colors.indicator,
                            ),
                          ),
                          AnimatedContainer(
                            duration: Duration(milliseconds: 300),

                            width: currentSelected == 2 ? 20 : 8,
                            height: 8,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: currentSelected == 2
                                  ? colors.mainColor
                                  : colors.indicator,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        introModel.introTitle,
                        style: TextStyles.inter16Medium.copyWith(
                          color: colors.mainText,
                          fontWeight: .bold,
                        ),
                      ),
                      Text(
                        introModel.introContent,
                        style: TextStyles.inter16Medium.copyWith(
                          color: colors.secText,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),

            SizedBox(height: 12),
            Row(
              mainAxisAlignment: .spaceBetween,
              children: [
                Expanded(
                  child: MyMainButton(
                    colors: colors,
                    buttonText: currentSelected < intros.length - 1
                        ? "next".tr()
                        : "get_started".tr(),
                    onPressed: () {
                      if (currentSelected < intros.length - 1) {
                        pageController.nextPage(
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      } else {
                        Navigator.pushNamed(context, LoginScreen.routeName);
                      }
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
