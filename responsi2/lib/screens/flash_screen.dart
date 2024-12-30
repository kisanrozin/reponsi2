import 'package:flutter/material.dart';
import 'dart:async';

import 'package:responsi2/screens/login_screen.dart'; 

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipOval(
              child: Image.asset(
                'assets/images/logo.png',
                height: 150,
                width: 150,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 20),
            // Teks atau label yang ingin Anda tampilkan
            const Text(
              'BuangIn',
              style: TextStyle(
                fontSize: 27,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            // Loading indicator
            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
