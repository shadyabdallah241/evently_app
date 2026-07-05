import 'package:easy_localization/easy_localization.dart';
import 'package:evently/tabs/home_tab.dart';
import 'package:evently/util/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/event_list_provider.dart';
import '../theme/app_colors_extension.dart';

class LoveTab extends StatefulWidget {
  const LoveTab({super.key});

  @override
  State<LoveTab> createState() => _LoveTabState();
}

class _LoveTabState extends State<LoveTab> {
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Provider.of<EventListProvider>(
      context,
      listen: false,
    ).getFavoriteEvents("");
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColorsExtension>()!;
    EventListProvider eventListProvider = Provider.of<EventListProvider>(
      context,
    );

    return SafeArea(
      child: Scaffold(
        backgroundColor: colors.background,
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(height: 12),
              TextField(
                controller: searchController,
                onChanged: (value) {
                  eventListProvider.getFavoriteEvents(value);
                },
                decoration: AppTextField.textFieldStyle(
                  colors: colors,
                  hintText: "search_placeholder".tr(),
                  prefixIcon: null,
                  suffixIcon: Icons.search,
                ),
              ),
              SizedBox(height: 12),
              eventListProvider.favoriteList.isEmpty
                  ? Center(child: Text("no_favorite_events_found".tr()))
                  : Expanded(
                      child: ListView.separated(
                        itemBuilder: (context, index) {
                          return MySlidable(
                            eventListProvider: eventListProvider,
                            index: index,
                            event: eventListProvider.favoriteList[index],
                          );
                        },
                        separatorBuilder: (context, index) {
                          return SizedBox(height: 12);
                        },
                        itemCount: eventListProvider.favoriteList.length,
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
