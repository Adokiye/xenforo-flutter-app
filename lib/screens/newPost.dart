import 'package:flutter/material.dart';
import 'package:xenforo/helpers/key.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:xenforo/components/loader.dart';
import 'package:xenforo/components/buttons/borderButton/index.dart';
import 'package:flutter/services.dart';
import 'package:xenforo/screens/threadInfo.dart';
import 'package:xenforo/models/forumContent.dart';

class NewPost extends StatefulWidget {
  NewPost(
      {Key key,
      @required this.id,
      @required this.title,
      @required this.forumData})
      : super(key: key);
  final int id;
  final String title;
  final ForumContent forumData;

  @override
  _NewPostState createState() => _NewPostState();
}

class _NewPostState extends State<NewPost> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  String _message;
  Future<dynamic> newPost;
  bool _showLoader = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  Future<dynamic> postThread() async {
    _showLoader = true;
    final response = await http.post(
      url + 'posts/?thread_id='+widget.id.toString()+
      '&message='+_message,
      headers: <String, String>{
        'XF-Api-Key': apiKey,
        'Content-Type': 'application/x-www-form-urlencoded',
      },
    );
    if (response.statusCode == 200) {
       setState((){
         _showLoader = false;
      });
      // If the server did return a 200 OK response,
      // then parse the JSON.
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text('Post Created Successfully',
            style: TextStyle(
              fontSize: 15.0,
              color: Colors.white,
              fontWeight: FontWeight.w300,
            )),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Color(0xff1281dd),
        elevation: 0.0,
      ));
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) =>
                ThreadInfo(forumData: widget.forumData, title: widget.title),
          ),
          (Route<dynamic> route) => false);
    } else {
      setState((){
         _showLoader = false;
      });
      // If the server did not return a 200 OK response,
      // then throw an exception.
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text('Failed to post message',
            style: TextStyle(
              fontSize: 15.0,
              color: Colors.white,
              fontWeight: FontWeight.w300,
            )),
        action: SnackBarAction(label: 'RETRY', onPressed: postThread),
        //  behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.red,
        elevation: 0.0,
      ));
      //throw Exception('Failed to load post thread');
    }
  }

  @override
  void initState() {
    super.initState();
  }

  void post() {
    if (_formKey.currentState.validate()) {
//    If all data are correct then save data to our variables
      _formKey.currentState.save();
      postThread();
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
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(widget.title),
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
        _showLoader ? Loader() : Container(),
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
                hintText: 'Enter message of post',
                hintStyle: TextStyle(
                  fontSize: 13.0,
                  color: const Color(0xffC4C4C4),
                ),
                border: InputBorder.none,
              ),
              validator: (val) {
                if (val.length == 0) {
                  return "Message is required for this post";
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
            margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.03),
            child: BorderButton(
              title: 'POST',
              onPressed: post,
            ))
      ],
    );
  }
}
