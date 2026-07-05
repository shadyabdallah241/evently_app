class Event {
  static const String collection = "Events";
  String userId;
  String eventid;
  String eventCategory;
  String eventImage;
  String eventImageDark;
  String eventTitle;
  String eventDescription;
  DateTime eventDate;
  String eventTime;
  bool isFavorite;

  Event({
    this.eventid = "",
    required this.userId,
    required this.eventImage,
    required this.eventImageDark,
    required this.eventCategory,
    required this.eventTitle,
    required this.eventDescription,
    required this.eventDate,
    required this.eventTime,
    this.isFavorite = false,
  });

  String getImagePth(bool isDark) {
    if (isDark == true) {
      return eventImageDark;
    } else {
      return eventImage;
    }
  }

  Event.fromFirestore(Map<String, dynamic> data)
    : this(
        userId: data["userId"],
        eventid: data["eventid"],
        eventImage: data["eventImage"],
        eventImageDark: data["eventImageDark"],
        eventCategory: data["eventCategory"],
        eventTitle: data["eventTitle"],
        eventDescription: data["eventDescription"],
        eventDate: DateTime.fromMillisecondsSinceEpoch(data["eventDate"]),
        eventTime: data["eventTime"],
        isFavorite: data["isFavorite"],
      );

  Map<String, dynamic> toFirestore() {
    return {
      "userId": userId,
      "eventid": eventid,
      "eventImage": eventImage,
      "eventImageDark": eventImageDark,
      "eventCategory": eventCategory,
      "eventTitle": eventTitle,
      "eventDescription": eventDescription,
      "eventDate": eventDate.millisecondsSinceEpoch,
      "eventTime": eventTime,
      "isFavorite": isFavorite,
    };
  }
}
