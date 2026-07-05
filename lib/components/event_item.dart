import 'package:easy_localization/easy_localization.dart';
import 'package:evently/providers/app_theme_provider.dart';
import 'package:evently/providers/event_list_provider.dart';
import 'package:evently/screens/event_details_screen.dart';
import 'package:evently/theme/app_colors_extension.dart';
import 'package:evently/util/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/event.dart';

class EventItem extends StatelessWidget {
  final Event event;

  const EventItem({super.key, required this.event});

  final bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColorsExtension>()!;
    var themeProvider = Provider.of<AppThemeProvider>(context);
    final isDark = themeProvider.isDark(context);
    var eventListProvider = Provider.of<EventListProvider>(context);

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          EventDetailsScreen.routeName,
          arguments: event,
        );
      },
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.asset(
              event.getImagePth(isDark),
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            height: 212,
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: colors.stroke, width: 1),
            ),
            child: Column(
              crossAxisAlignment: .start,
              mainAxisAlignment: .spaceBetween,
              children: [
                Container(
                  width: 75,
                  height: 40,
                  decoration: BoxDecoration(
                    color: colors.container,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: colors.stroke),
                  ),
                  child: Center(
                    child: Text(
                      DateFormat("MMM d").format(event.eventDate),
                      textAlign: TextAlign.center,
                      style: TextStyles.inter16Medium.copyWith(
                        color: colors.mainColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: colors.container,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: colors.stroke),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        event.eventTitle.tr(),
                        style: TextStyles.inter14Bold.copyWith(
                          color: colors.mainText,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          eventListProvider.addToFavorite(event);
                          eventListProvider.toggleFavorite(event);
                          eventListProvider.getFavoriteEvents("");
                        },
                        child: Icon(
                          event.isFavorite
                              ? Icons.favorite
                              : Icons.favorite_outline,
                          color: colors.mainColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
