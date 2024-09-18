import 'package:alumni_connect/presentation/pages/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3000),
    );
    _navigate();
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  Future<void> _navigate() async {
    await Future.delayed(const Duration(seconds: 3), () {});
    if (mounted) {
      Navigator.of(context).pushAndRemoveUntil(
        StudentLoginPage.getRoute(),
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(
              flex: 2,
            ),
            // Logo or splash screen image
            SizedBox(
              height: size.height * .3,
              child: Image.asset(

                'assets/images/image_logo.png',
                height: size.height * .3,

                // 'assets/images/image2.png',
                alignment: Alignment.center,
                fit: BoxFit.fill,
              ),
            ),
            const Spacer(flex: 2),
            // Loading animation
            const SpinKitCircle(
              color: Colors.white,
              size: 50.0,
            ),
            const SizedBox(height: 40),
            const Spacer(flex: 1),
          ],
        ),
      ),
    );
  }
}
