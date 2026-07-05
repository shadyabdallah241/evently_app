import 'package:easy_localization/easy_localization.dart';
import 'package:evently/screens/create_event_screen.dart';
import 'package:evently/util/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/event.dart';
import '../providers/app_theme_provider.dart';
import '../providers/event_list_provider.dart';
import '../theme/app_colors_extension.dart';

class EventDetailsScreen extends StatelessWidget {
  static const String routeName = "EventDetailsScreen";

  const EventDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var event = ModalRoute.of(context)!.settings.arguments as Event;
    var themeProvider = Provider.of<AppThemeProvider>(context);
    final bool isDark = themeProvider.appTheme == ThemeMode.dark;
    final colors = Theme.of(context).extension<AppColorsExtension>()!;
    var eventListProvider = Provider.of<EventListProvider>(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: colors.background,
        appBar: AppBar(
          scrolledUnderElevation: 0,
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back_ios_sharp, color: colors.mainColor),
          ),
          title: Text("event_title".tr(), style: TextStyles.inter16Medium),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CreateEventScreen(event: event),
                        ),
                      );
                    },
                    child: Icon(Icons.edit, color: colors.mainColor),
                  ),
                  SizedBox(width: 5),
                  GestureDetector(
                    onTap: () {
                      eventListProvider.removeEvent(event.eventid);
                      Navigator.pop(context);
                    },
                    child: Icon(Icons.delete, color: Colors.red),
                  ),
                ],
              ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: .start,
              spacing: 16,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: colors.stroke, width: 1),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: Image.asset(
                      isDark ? event.eventImageDark : event.eventImage,
                    ),
                  ),
                ),
                Text(
                  event.eventTitle,
                  style: TextStyles.inter16Bold.copyWith(
                    color: colors.mainText,
                    fontWeight: .w400,
                  ),
                ),
                Container(
                  width: .infinity,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: colors.container,
                    border: Border.all(color: colors.stroke, width: 2),
                  ),
                  child: ListTile(
                    contentPadding: EdgeInsets.symmetric(horizontal: 7),
                    leading: Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: colors.stroke, width: 2),
                        color: colors.container,
                      ),
                      child: Icon(
                        Icons.calendar_month,
                        color: colors.mainColor,
                      ),
                    ),
                    title: Column(
                      crossAxisAlignment: .start,
                      children: [
                        Text(
                          DateFormat(
                            'dd MMMM yyyy',
                          ).format(event.eventDate).tr(),
                          style: TextStyles.inter16Medium.copyWith(
                            color: colors.mainText,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          event.eventTime.tr(),
                          style: TextStyles.inter14Medium.copyWith(
                            color: colors.secText,
                            fontWeight: .w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Text("description_label".tr(), style: TextStyles.inter16Medium),
                Container(
                  width: .infinity,
                  height: 179,
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: colors.container,
                    border: Border.all(color: colors.stroke, width: 2),
                  ),
                  child: Text(
                    event.eventDescription.tr(),
                    style: TextStyles.inter14Medium,
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
