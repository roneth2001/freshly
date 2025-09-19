import 'package:flutter/material.dart';
import 'package:freshly_app/screens/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Removes debug banner
      title: 'Freshly App',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const MainScreen(), // Your home screen
    );
  }
}