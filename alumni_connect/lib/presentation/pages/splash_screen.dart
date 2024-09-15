import 'package:alumni_connect/presentation/pages/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:thanos_snap_effect/thanos_snap_effect.dart';

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
    await Future.delayed(const Duration(seconds: 1), () async {
      await _animationController.forward();
    });
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
            const Spacer(),
            const Spacer(),
            // Logo or splash screen image
            Snappable(
              animation: _animationController.view,
              outerPadding: const EdgeInsets.all(40),
              style: const SnappableStyle(
                particleSize: SnappableParticleSize.absoluteDp(
                  width: 8,
                  height: 8,
                ),
              ),
              child: SizedBox(
                height: size.height * .3,
                child: Image.asset(
                  'assets/images/image.png',
                  height: size.height * .3,
                ),
              ),
            ),
            const Spacer(),
            const Spacer(),
            // Loading animation
            const SpinKitCircle(
              color: Colors.white,
              size: 50.0,
            ),
            const SizedBox(height: 40),
            // App Name (optional)
            Text(
              'Alumni Connect',
              style: TextStyle(
                fontSize: size.height * .05,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
