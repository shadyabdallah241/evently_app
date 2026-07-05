import 'package:evently/models/category.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../firebase_functions.dart';
import '../models/event.dart';

class EventListProvider extends ChangeNotifier {
  int selectedIndex = 0;
  List<Event> eventsList = [];
  List<Event> filteredList = [];
  List<Event> favoriteList = [];

  String get currentUserId => FirebaseAuth.instance.currentUser?.uid ?? "";

  Future<void> getAllEventFromFirestore() async {
    try {
      var querySnapShot = await FirebaseFunctions.getEventsCollection()
          .where("userId", isEqualTo: currentUserId)
          .get();
      eventsList = querySnapShot.docs.map((doc) => doc.data()).toList();
      filteredList = List.from(eventsList);
      filteredList.sort(
        (event1, event2) => event1.eventDate.compareTo(event2.eventDate),
      );
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future<void> getFilterEvents(int selectedIndex) async {
    try {
      filteredList = eventsList.where((event) {
        return event.eventCategory == categories[selectedIndex].text;
      }).toList();
      filteredList.sort((event1, event2) {
        return event1.eventDate.compareTo(event2.eventDate);
      });
      print(filteredList);
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future<void> getFavoriteEvents(String searchValue) async {
    try {
      var querySnapShot = await FirebaseFunctions.getEventsCollection()
          .where("isFavorite", isEqualTo: true)
          .get();
      var allfavoriteList = querySnapShot.docs.map((doc) {
        return doc.data();
      }).toList();

      if (searchValue.isEmpty) {
        favoriteList = allfavoriteList;
      } else {
        favoriteList = allfavoriteList.where((event) {
          return event.eventTitle.toLowerCase().contains(
            searchValue.toLowerCase(),
          );
        }).toList();
      }
      favoriteList.sort((event1, event2) {
        return event1.eventDate.compareTo(event2.eventDate);
      });
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future<void> changeSelectedIndex(int userSelectedIndex) async {
    selectedIndex = userSelectedIndex;
    selectedIndex == 0
        ? getAllEventFromFirestore()
        : getFilterEvents(selectedIndex);
  }

  Future<void> toggleFavorite(Event event) async {
    event.isFavorite = !event.isFavorite;
    await FirebaseFunctions.getEventsCollection().doc(event.eventid).update({
      "isFavorite": event.isFavorite,
    });
    notifyListeners();
  }

  Future<void> addToFavorite(Event event) async {
    try {
      if (event.isFavorite == true) {
        favoriteList.add(event);
      } else if (event.isFavorite == false) {
        favoriteList.remove(event);
      }
      await FirebaseFunctions.getEventsCollection().doc(event.eventid).update({
        "isFavorite": event.isFavorite,
      });
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future<void> removeEvent(String eventId) async {
    try {
      await FirebaseFunctions.getEventsCollection().doc(eventId).delete();
      eventsList.removeWhere((event) => event.eventid == eventId);
      filteredList.removeWhere((event) => event.eventid == eventId);
      favoriteList.removeWhere((event) => event.eventid == eventId);
      notifyListeners();
    } catch (e) {
      await getAllEventFromFirestore();
    }
  }
}
