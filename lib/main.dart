import 'package:flutter/material.dart';
import 'package:flightplanner/pages/homepage.dart';
import 'package:flightplanner/core/bottom_nav_bar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
          )
      ),
      home: const HomePage(),
      routes: {
        '/navbar':(context) => const BottomNavBar(),
        '/homepage':(context) => const HomePage(),

      },
    );
  }
}