import 'package:flutter/material.dart';
import 'screens/flash_screen.dart';
import 'screens/login_screen.dart';
import 'screens/manage_account_screen.dart';
import 'screens/home_screen.dart';
import 'screens/profile_screen.dart';

void main() {
  runApp(MyApp());
}

// ignore: use_key_in_widget_constructors
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BuangIn',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:  SplashScreen(),
      routes: {
        '/login': (context) => LoginScreen(),
        '/home': (context) =>  WasteManagementApp(),
        '/profile': (context) => ProfileScreen(),
        '/manageAccount': (context) => ManageAccountScreen(),
      },
    );
  }
}
