import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:xenforo/helpers/key.dart';
import 'package:xenforo/models/forumContent.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Layout extends StatefulWidget {
  Layout({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _LayoutState createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(backgroundColor: Color(0xff007C89),))
      );
  }
}



