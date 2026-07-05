// import 'package:evently/screens/home_screen.dart';
// import 'package:evently/screens/login_screen.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
//
// class MainScreen extends StatelessWidget {
//   static const String routeName = "MainPage";
//
//   const MainScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: StreamBuilder<User?>(
//         stream: FirebaseAuth.instance.authStateChanges(),
//         builder: (context, snapshot) {
//           final prefs = await SharedPreferences.getInstance();
//           final bool seenOnboarding = prefs.getBool("onboarding_completed") ?? false;
//           if (snapshot.hasData) {
//             return HomeScreen();
//           } else {
//             return LoginScreen();
//           }
//         },
//       ),
//     );
//   }
// }
