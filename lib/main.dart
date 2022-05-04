// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vote_app/pages/home_page.dart';
import 'package:vote_app/services/functions.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Functions(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: Colors.amber[300],
          appBarTheme: AppBarTheme(
            elevation: 0,
          ),
        ),
        title: 'Material Application',
        home: HomePage(),
      ),
    );
  }
}
