import 'package:flutter/material.dart';
import 'package:responsi_uts/screens/home_page.dart';
import 'package:responsi_uts/screens/login_page.dart';
import 'package:responsi_uts/screens/profile_page.dart';
import 'package:responsi_uts/screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/home': (context) => HomePage(),
        '/akun': (context) => ProfilePage(),
        '/login': (context) => loginPage(),
        '/splash': (context) => SplashScreen(),
      },
    );
  }
}
