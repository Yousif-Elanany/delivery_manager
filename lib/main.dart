import 'package:delivery_manager/screens/Home_Screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode thememode = ThemeMode.light;
  void toggle() {
    setState(() {
      if (thememode == ThemeMode.light) {
        thememode = ThemeMode.dark;
      } else {
        thememode = ThemeMode.light;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Delivery Manager',
      theme: ThemeData(
        primaryColor: Colors.blue[900],
        accentColor: Colors.white,
      ),
      darkTheme: ThemeData(
        primaryColor: Colors.grey[900],
        accentColor: Colors.grey[600],
      ),
      themeMode: thememode,                                                                 
      home: Homescreen(toggle),
    );
  }
}
