import 'package:flutter/material.dart';
import 'dart:collection';
import 'package:xenforo/models/user.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';


class UserModel extends ChangeNotifier {

  String _id = '';
  User _user;
  
  UserModel(){
   getId();
  }

  get id => _id;

   void getId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String id = (await prefs.getString('id') ?? '');
    
    _id = id;
    notifyListeners();
  }

   Future<bool> setId(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
   _id = value;
    notifyListeners();
    return prefs.setString('id', value);
  }

  
}
