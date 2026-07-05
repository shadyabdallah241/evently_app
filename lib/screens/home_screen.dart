import 'package:easy_localization/easy_localization.dart';
import 'package:evently/tabs/home_tab.dart';
import 'package:evently/tabs/love_tab.dart';
import 'package:evently/tabs/profile_tab.dart';
import 'package:evently/util/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/event_list_provider.dart';
import '../theme/app_colors_extension.dart';
import 'create_event_screen.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "HomeScreen";

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColorsExtension>()!;
    late final List<Widget> tabs = [HomeTab(), LoveTab(), ProfileTab()];
    return Scaffold(
      backgroundColor: colors.background,
      body: tabs[currentPageIndex],
      extendBody: true,
      floatingActionButton: FloatingActionButton(
        elevation: 0,
        backgroundColor: colors.mainColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
        onPressed: () {
          Navigator.pushNamed(context, CreateEventScreen.routeName);
          Provider.of<EventListProvider>(
            context,
            listen: false,
          ).getAllEventFromFirestore();
        },
        child: Icon(Icons.add, size: 24, color: colors.white),
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        child: NavigationBar(
          labelBehavior: .alwaysShow,
          onDestinationSelected: (index) {
            setState(() {
              currentPageIndex = index;
            });
          },
          backgroundColor: colors.container,
          selectedIndex: currentPageIndex,
          indicatorColor: Colors.transparent,
          labelTextStyle: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return TextStyles.inter14Medium.copyWith(color: colors.mainColor);
            }
            return TextStyles.inter14Medium.copyWith(color: colors.secText);
          }),
          destinations: [
            NavigationDestination(
              selectedIcon: Icon(Icons.home, color: colors.mainColor),
              icon: Icon(Icons.home_outlined, color: colors.disable),
              label: "home".tr(),
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.favorite, color: colors.mainColor),
              icon: Icon(Icons.favorite_outline, color: colors.disable),
              label: "love".tr(),
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.person, color: colors.mainColor),
              icon: Icon(Icons.person_outline, color: colors.disable),
              label: "profile".tr(),
            ),
          ],
        ),
      ),
    );
  }
}
