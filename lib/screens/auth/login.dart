import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:xenforo/helpers/key.dart';
import 'package:xenforo/models/forumContent.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:xenforo/components/loader.dart';

class Login extends StatefulWidget {
  Login({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _LoginState createState() => _LoginState();
}
//iamf//abinne
class _LoginState extends State<Login> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff1281dd),
        body: Center(
            child: CircularProgressIndicator(
      backgroundColor: Color(0xff007C89),
    )));
  }
}
