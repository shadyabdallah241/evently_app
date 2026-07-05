import 'package:evently/screens/google_auth_service.dart';
import 'package:evently/util/app_images_path.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/event_list_provider.dart';
import '../theme/app_colors_extension.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName = "SplashScreen";

  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  initState() {
    super.initState();
    navigateToNextScreen();
  }

  Future<void> navigateToNextScreen() async {
    final eventProvider = Provider.of<EventListProvider>(
      context,
      listen: false,
    );

    await Future.wait([
      eventProvider.getAllEventFromFirestore(),
      Future.delayed(Duration(seconds: 2)),
    ]);
    if (mounted) {
      Navigator.pushNamed(context, await AuthService.getInitialRoute());
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColorsExtension>()!;

    return Scaffold(
      backgroundColor: colors.background,
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(24),
            child: Align(
              alignment: .center,
              child: Image.asset(AppImagesPath.logoH),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 32),
            child: Align(
              alignment: .bottomCenter,
              child: Image.asset(AppImagesPath.branding, width: 200),
            ),
          ),
        ],
      ),
    );
  }
}
