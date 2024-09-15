import 'package:alumni_connect/presentation/pages/home_page.dart';
import 'package:alumni_connect/presentation/pages/login_screen.dart';
import 'package:alumni_connect/presentation/widgets/gradient_background.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  void _navigateToHome() async {
    await Future.delayed(
      const Duration(
        seconds: 3,
      ),
    );

    if (mounted) {
      Navigator.pushAndRemoveUntil(
        context,
        StudentLoginPage.getRoute(),
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackground(
        child: Center(
          child: Image.asset(
            'assets/images/image.png',
            height: 100,
          ), // Replace with your image path
        ),
      ),
    );
  }
}
