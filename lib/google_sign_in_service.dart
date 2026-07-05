import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuthServices {
  static Future<UserCredential?> signInWithGoogle() async {
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
    if (gUser == null) return null;
    final GoogleSignInAuthentication gAuth = await gUser.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: gAuth.accessToken,
      idToken: gAuth.idToken,
    );
    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithCredential(credential);
    await FirebaseFirestore.instance
        .collection("users")
        .doc(userCredential.user!.uid)
        .set({
          "user name": userCredential.user!.displayName,
          "email": userCredential.user!.email,
        });
    return userCredential;
  }
}
