import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:xenforo/helpers/key.dart';
import 'package:xenforo/models/forumContent.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:xenforo/components/loader.dart';
import 'package:xenforo/components/buttons/fullButton/index.dart';
import 'package:flutter/services.dart';

class NewThread extends StatefulWidget {
  NewThread({Key key, @required this.id}) : super(key: key);
  final int id;

  @override
  _NewThreadState createState() => _NewThreadState();
}

class _NewThreadState extends State<NewThread> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  String _title;
  String _message;

  @override
  void initState() {
    super.initState();
  }

  void post() {
    if (_formKey.currentState.validate()) {
//    If all data are correct then save data to our variables
      _formKey.currentState.save();
    } else {
//    If all data are not valid then start auto validation.
      setState(() {
        _autoValidate = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Thread'),
      ),
      body: new SingleChildScrollView(
        child: new Container(
          margin: new EdgeInsets.all(15.0),
          child: new Form(
            key: _formKey,
            autovalidate: _autoValidate,
            child: customForm(),
          ),
        ),
      ),
    );
  }

  Widget customForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        new Container(
            margin:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.03),
            width: MediaQuery.of(context).size.width * 0.90,
            decoration: BoxDecoration(
                border: Border(
              bottom: BorderSide(
                //                    <--- top side
                color: const Color(0xffC4C4C4),
                width: 1.0,
              ),
            )),
            child: new TextFormField(
              decoration: new InputDecoration(
                labelText: "Title",
                fillColor: Colors.white,
                hintText: 'Enter title of Thread',
                hintStyle: TextStyle(
                  fontSize: 13.0,
                  color: const Color(0xffC4C4C4),
                ),
                border: InputBorder.none,
              ),
              validator: (val) {
                if (val.length == 0) {
                  return "A title is required for the Thread";
                } else {
                  return null;
                }
              },
              style: new TextStyle(
                fontSize: 16.0,
                color: Colors.black,
                //    height: 1.0,
              ),
              onSaved: (String val) {
                _title = val;
              },
            )),
        new Container(
            margin:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.03),
            width: MediaQuery.of(context).size.width * 0.90,
            decoration: BoxDecoration(
                border: Border(
              bottom: BorderSide(
                //                    <--- top side
                color: const Color(0xffC4C4C4),
                width: 1.0,
              ),
            )),
            child: new TextFormField(
              keyboardType: TextInputType.multiline,
              maxLines: null,
              decoration: new InputDecoration(
                labelText: "Message",
                fillColor: Colors.white,
                hintText: 'Enter message of first post of the thread',
                hintStyle: TextStyle(
                  fontSize: 13.0,
                  color: const Color(0xffC4C4C4),
                ),
                border: InputBorder.none,
              ),
              validator: (val) {
                if (val.length == 0) {
                  return "This thread requires a message for it's first post";
                } else {
                  return null;
                }
              },
              style: new TextStyle(
                fontSize: 16.0,
                color: Colors.black,
                //    height: 1.0,
              ),
              onSaved: (String val) {
                _message = val;
              },
            )),
        Container(
            margin: EdgeInsets.only(top: 10.0),
            child: FullButton(
              title: 'POST',
              onPressed: post,
            ))
      ],
    );
  }
}
