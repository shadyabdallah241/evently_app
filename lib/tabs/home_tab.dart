import 'package:easy_localization/easy_localization.dart';
import 'package:evently/firebase_functions.dart';
import 'package:evently/providers/event_list_provider.dart';
import 'package:evently/util/dialog.dart';
import 'package:evently/util/text_styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

import '../components/category.dart';
import '../components/event_item.dart';
import '../models/category.dart';
import '../models/event.dart';
import '../providers/app_theme_provider.dart';
import '../providers/language_provider.dart';
import '../screens/create_event_screen.dart';
import '../theme/app_colors_extension.dart';
import '../util/app_images_path.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  final user = FirebaseAuth.instance.currentUser;
  late final Event event;

  // @override
  // void initState() {
  //   super.initState();
  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //     Provider.of<EventListProvider>(
  //       context,
  //       listen: false,
  //     ).getAllEventFromFirestore();
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColorsExtension>()!;
    final languageProvider = Provider.of<LanguageProvider>(context);
    var themeProvider = Provider.of<AppThemeProvider>(context);
    var eventListProvider = Provider.of<EventListProvider>(context);
    final bool isDark = themeProvider.appTheme == ThemeMode.dark;

    return SafeArea(
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(24),
                bottomLeft: Radius.circular(24),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                spacing: 8,
                children: [
                  Row(
                    mainAxisAlignment: .spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: .start,
                        children: [
                          Text(
                            "${"welcome".tr()} ✨",
                            style: TextStyles.inter14Medium.copyWith(
                              color: colors.secText,
                            ),
                          ),
                          SizedBox(height: 8),
                          FutureBuilder(
                            future: FirebaseFunctions.getUserData(),
                            builder: (context, snapshot) {
                              var userData = snapshot.data;
                              return Text(
                                userData != null
                                    ? "${userData["user name"]}"
                                    : "Loading...",
                                style: TextStyles.inter20Medium.copyWith(
                                  color: colors.mainText,
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              if (themeProvider.getThemeName() == "dark") {
                                themeProvider.changeTheme(ThemeMode.light);
                              } else {
                                themeProvider.changeTheme(ThemeMode.dark);
                              }
                            },
                            child: Image.asset(
                              themeProvider.getThemeName() == "dark"
                                  ? AppImagesPath.sunOutlined
                                  : AppImagesPath.sun,
                              width: 24,
                              color: colors.mainColor,
                            ),
                          ),
                          SizedBox(width: 8),
                          GestureDetector(
                            onTap: () {
                              languageProvider.isArabic(context)
                                  ? languageProvider.changeToEnglish(context)
                                  : languageProvider.changeToArabic(context);
                            },
                            child: Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: colors.mainColor,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                languageProvider.isArabic(context)
                                    ? "Ar"
                                    : "En",
                                style: TextStyles.inter14Bold.copyWith(
                                  color: colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(width: 16),
                  Row(
                    spacing: 10,
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 50,
                          width: 300,
                          child: ListView.separated(
                            scrollDirection: .horizontal,
                            itemCount: categories.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  eventListProvider.changeSelectedIndex(index);
                                },
                                child: Category(
                                  isSelected:
                                      eventListProvider.selectedIndex == index,
                                  categoryIcon: categories[index].getIcon(
                                    themeProvider.appTheme,
                                  ),
                                  categoryText: categories[index].text.tr(),
                                  selectedBackgroundColor: colors.mainColor,
                                  selectedTextColor: colors.white,
                                  unselectedBackgroundColor: isDark
                                      ? colors.container
                                      : colors.white,
                                  unselectedTextColor: colors.mainColor,
                                ),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return SizedBox(width: 10);
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 16),
          eventListProvider.filteredList.isEmpty
              ? Column(children: [Center(child: Text("no_events_found".tr()))])
              : Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: ListView.separated(
                      itemBuilder: (context, index) {
                        return MySlidable(
                          eventListProvider: eventListProvider,
                          index: index,
                          event: eventListProvider.filteredList[index],
                        );
                      },
                      separatorBuilder: (context, index) {
                        return SizedBox(height: 12);
                      },
                      itemCount: eventListProvider.filteredList.length,
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}

class MySlidable extends StatelessWidget {
  final int index;
  final Event event;
  final EventListProvider eventListProvider;

  const MySlidable({
    super.key,
    required this.eventListProvider,
    required this.index,
    required this.event,
  });

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: ValueKey(eventListProvider.filteredList[index].eventid),
      startActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (context) {
              MyDialogs.showMessage(
                context: context,
                message: "Are you sure you want to delete this document?",
                buttonsCount: 2,
                title: "Delete Document",
                firstButtonOnPressed: () {
                  eventListProvider.removeEvent(
                    eventListProvider.filteredList[index].eventid,
                  );
                },
                firstButtonText: "Yes",
                secondButtonOnPressed: () {},
                secondButtonText: "No",
              );
            },
            backgroundColor: const Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          ),
        ],
      ),
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            flex: 2,
            onPressed: (context) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CreateEventScreen(
                    event: eventListProvider.filteredList[index],
                  ),
                ),
              );
            },
            backgroundColor: const Color(0xFF7BC043),
            foregroundColor: Colors.white,
            icon: Icons.edit,
            label: 'Edit',
          ),
        ],
      ),
      child: EventItem(event: event),
    );
  }
}
