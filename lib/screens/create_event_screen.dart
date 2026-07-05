import 'package:easy_localization/easy_localization.dart';
import 'package:evently/components/category.dart';
import 'package:evently/firebase_functions.dart';
import 'package:evently/models/category.dart';
import 'package:evently/models/event.dart';
import 'package:evently/util/app_images_path.dart';
import 'package:evently/util/app_text_field.dart';
import 'package:evently/util/my_main_button.dart';
import 'package:evently/util/text_styles.dart';
import 'package:evently/validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/app_theme_provider.dart';
import '../providers/event_list_provider.dart';
import '../theme/app_colors_extension.dart';
import 'home_screen.dart';

class CreateEventScreen extends StatefulWidget {
  static const String routeName = "CreateEventScreen";
  final Event? event;

  const CreateEventScreen({super.key, this.event});

  @override
  State<CreateEventScreen> createState() => _CreateEventScreenState();
}

class _CreateEventScreenState extends State<CreateEventScreen> {
  int selectedIndex = 0;
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  String formatDate = "";
  String formatTime = "";
  bool isDateValid = true;
  bool isTimeValid = true;
  String selectedEventCategory = "";
  String selectedEventImage = "";
  String selectedEventImageDark = "";
  bool isFavorite = false;
  late EventListProvider eventListProvider;
  final formKey = GlobalKey<FormState>();
  late bool isEditMode = widget.event != null;

  String get currentUserId => FirebaseAuth.instance.currentUser?.uid ?? "";

  final TextEditingController eventTitleController = TextEditingController();
  final TextEditingController eventDescriptionController =
      TextEditingController();

  void finishAction() {}

  @override
  void initState() {
    super.initState();
    if (isEditMode) {
      isFavorite = widget.event!.isFavorite;
      eventTitleController.text = widget.event!.eventTitle;
      eventDescriptionController.text = widget.event!.eventDescription;
      selectedDate = widget.event!.eventDate;
      formatDate = DateFormat("MMM d, y").format(selectedDate!);
      formatTime = widget.event!.eventTime;
      selectedIndex =
          categories.indexWhere((c) => c.text == widget.event!.eventCategory) -
          1;
      if (selectedIndex < 0) selectedIndex = 0;
    }
  }

  List<String> imagesLight = [
    AppImagesPath.sport,
    AppImagesPath.bookingClub,
    AppImagesPath.birthday,
    AppImagesPath.exhibition,
    AppImagesPath.meeting,
  ];
  List<String> imagesDark = [
    AppImagesPath.sportDark,
    AppImagesPath.bookingClubDark,
    AppImagesPath.birthdayDark,
    AppImagesPath.exhibitionDark,
    AppImagesPath.meetingDark,
  ];

  Future<void> selecteDate(BuildContext context) async {
    {
      final DateTime? date = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365)),
      );
      selectedDate = date;

      if (selectedDate != null) {
        setState(() {
          formatDate = DateFormat("MMM d, y").format(selectedDate!);
          isDateValid = true;
        });
      }
    }
  }

  Future<void> selectTime(BuildContext context) async {
    {
      final TimeOfDay? time = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );
      selectedTime = time;
      if (selectedTime != null) {
        setState(() {
          formatTime = selectedTime!.format(context);
          isTimeValid = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<AppThemeProvider>(context);
    final bool isDark = themeProvider.appTheme == ThemeMode.dark;
    final colors = Theme.of(context).extension<AppColorsExtension>()!;
    eventListProvider = Provider.of<EventListProvider>(context);
    selectedEventCategory = categories[selectedIndex + 1].text;
    selectedEventImage = imagesLight[selectedIndex];
    selectedEventImageDark = imagesDark[selectedIndex];

    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        backgroundColor: colors.background,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back_ios, color: colors.mainColor),
          ),
          title: Text(
            isEditMode ? "update_event".tr() : "header_title".tr(),
            style: TextStyle(fontSize: 20),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: .start,
              children: [
                Container(
                  clipBehavior: .antiAlias,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: colors.stroke),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset(
                      isDark ? selectedEventImageDark : selectedEventImage,
                    ),
                  ),
                ),
                SizedBox(height: 16),
                SizedBox(
                  height: 40,
                  child: ListView.separated(
                    scrollDirection: .horizontal,
                    itemCount: categories.length - 1,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () => setState(() {
                          selectedIndex = index;
                        }),
                        child: Category(
                          isSelected: selectedIndex == index,
                          categoryIcon: categories[index + 1].getIcon(
                            themeProvider.appTheme,
                          ),
                          categoryText: categories[index + 1].text.tr(),
                          selectedBackgroundColor: colors.mainColor,
                          selectedTextColor: colors.white,
                          unselectedBackgroundColor: isDark
                              ? colors.container
                              : colors.white,
                          unselectedTextColor: colors.mainColor,
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => SizedBox(width: 10),
                  ),
                ),
                SizedBox(height: 16),
                Text("input_title_label".tr(), style: TextStyle(fontSize: 16)),
                TextFormField(
                  controller: eventTitleController,
                  validator: Validator.validateEventTitle,
                  decoration: AppTextField.textFieldStyle(
                    colors: colors,
                    hintText: "input_title_placeholder".tr(),
                    prefixIcon: null,
                    suffixIcon: null,
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  "input_description_label".tr(),
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 8),
                SizedBox(
                  height: 150,
                  child: TextFormField(
                    controller: eventDescriptionController,
                    validator: Validator.validateEventDescription,
                    textAlignVertical: .top,
                    expands: true,
                    maxLines: null,
                    minLines: null,
                    keyboardType: .multiline,
                    decoration: AppTextField.textFieldStyle(
                      colors: colors,
                      hintText: "input_description_placeholder".tr(),
                      prefixIcon: null,
                      suffixIcon: null,
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: .spaceBetween,
                  children: [
                    Row(
                      spacing: 4,
                      children: [
                        Icon(Icons.calendar_month, color: colors.mainColor),
                        SizedBox(width: 5),
                        Text(
                          "date_label".tr(),
                          style: TextStyles.inter16Medium.copyWith(
                            color: colors.mainColor,
                          ),
                        ),
                      ],
                    ),

                    TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: .zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: GestureDetector(
                        onTap: () {
                          selecteDate(context);
                        },
                        child: Text(
                          selectedDate == null
                              ? "date_action".tr()
                              : formatDate,
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            decorationColor: colors.mainColor,
                            color: isDateValid ? colors.mainColor : colors.red,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: .spaceBetween,

                  children: [
                    Row(
                      spacing: 4,
                      children: [
                        Icon(Icons.access_time, color: colors.mainColor),
                        SizedBox(width: 5),
                        Text(
                          "time_label".tr(),
                          style: TextStyles.inter16Medium.copyWith(
                            color: colors.mainColor,
                          ),
                        ),
                      ],
                    ),
                    TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: .zero,
                        tapTargetSize: .shrinkWrap,
                      ),
                      child: GestureDetector(
                        onTap: () {
                          selectTime(context);
                        },
                        child: Text(
                          formatTime.isEmpty
                              ? "time_action".tr()
                              : formatTime.tr(),
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            decorationColor: colors.mainColor,
                            color: isTimeValid ? colors.mainColor : colors.red,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 25),
                SizedBox(
                  width: .infinity,
                  child: MyMainButton(
                    colors: colors,
                    buttonText: widget.event == null
                        ? "submit_button".tr()
                        : "update_event".tr(),
                    onPressed: () async {
                      setState(() {
                        if (selectedDate == null) isDateValid = false;
                        if (formatTime.isEmpty) isTimeValid = false;
                      });
                      if (formKey.currentState!.validate() &&
                          selectedDate != null &&
                          formatTime.isNotEmpty) {
                        Event event = Event(
                          eventid: widget.event?.eventid ?? "",
                          userId: currentUserId,
                          isFavorite: isFavorite,
                          eventImage: selectedEventImage,
                          eventImageDark: selectedEventImageDark,
                          eventCategory: selectedEventCategory,
                          eventTitle: eventTitleController.text,
                          eventDescription: eventDescriptionController.text,
                          eventDate: selectedDate!,
                          eventTime: formatTime.toString(),
                        );
                        if (widget.event == null) {
                          await FirebaseFunctions.addEventToFireStore(event);
                          if (context.mounted) {
                            eventListProvider.selectedIndex = selectedIndex + 1;
                            eventListProvider.getAllEventFromFirestore();
                            Navigator.pushNamed(context, HomeScreen.routeName);
                          }
                        } else {
                          await FirebaseFunctions.updateEventToFireStore(event);
                          if (context.mounted) {
                            eventListProvider.selectedIndex = selectedIndex + 1;
                            eventListProvider.getAllEventFromFirestore();
                            Navigator.pushNamed(
                              context,
                              HomeScreen.routeName,
                              arguments: 1,
                            );
                          }
                        }
                      }
                    },
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
