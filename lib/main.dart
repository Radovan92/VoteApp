// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:vote_app/pages/home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.amber[300],
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.deepPurple),
          ),
        ),
        appBarTheme: AppBarTheme(
          elevation: 0,
        ),
      ),
      title: 'Material Application',
      home: HomePage(),
    );
  }
}
