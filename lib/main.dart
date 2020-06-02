import 'package:flutter/material.dart';
import 'package:xenforo/helpers/color.dart';
import 'package:xenforo/screens/home.dart';
import 'package:provider/provider.dart';
import 'package:xenforo/providers/user.dart';

void main() => runApp(ChangeNotifierProvider(
    create: (_) => new UserModel(), child: MyApp()));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Xenforo Forum',
      theme: ThemeData(
        splashColor: Colors.white.withOpacity(0.25),
        fontFamily: 'Gilroy',
        primarySwatch: colorCustom,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        primaryColor: const Color(0xff1281dd),
      ),
      home: MyHomePage(title: 'Xenforo Forum'),
    );
  }
}

