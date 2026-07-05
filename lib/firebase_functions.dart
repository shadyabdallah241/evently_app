import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently/models/event.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseFunctions {
  static CollectionReference<Event> getEventsCollection() {
    return FirebaseFirestore.instance
        .collection(Event.collection)
        .withConverter<Event>(
          fromFirestore: (snapshot, _) {
            return Event.fromFirestore(snapshot.data()!);
          },
          toFirestore: (event, _) {
            return event.toFirestore();
          },
        );
  }

  static Future<void> addEventToFireStore(Event event) {
    CollectionReference<Event> collectionRef = getEventsCollection();
    DocumentReference<Event> documentRef = collectionRef.doc();
    event.eventid = documentRef.id;
    return documentRef.set(event);
  }

  static Future<void> updateEventToFireStore(Event event) {
    CollectionReference<Event> collectionRef = getEventsCollection();
    return collectionRef.doc(event.eventid).update(event.toFirestore());
  }

  static Future<Map<String, dynamic>?> getUserData() async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    DocumentSnapshot userDoc = await FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .get();

    if (userDoc.exists) {
      return userDoc.data() as Map<String, dynamic>;
    } else {
      return null;
    }
  }
}
