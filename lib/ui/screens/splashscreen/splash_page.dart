import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              "assets/image/splash_logo.png",
              width: 235,
              height: 80,
            ),
            Image.asset(
              "assets/image/slogan.png",
              width: 345,
              height: 300,
            ),
            const Text(
              "Version 1.0.0",
              style: TextStyle(
                color: Color(0xff1565C0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
