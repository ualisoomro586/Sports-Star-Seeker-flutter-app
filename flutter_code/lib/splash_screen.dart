import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    // double width = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Container(
      height: height * 10,
      decoration: const BoxDecoration(
          gradient:
              LinearGradient(colors: [Color(0xFF8EC5FC), Color(0xFFE0C3FC)])),
      child: Center(
        child: Image.asset(
          'assets/logo2.png', // Replace with the actual path to your image
          width: 400.0,
        ),
      ),
    ));
  }
}
