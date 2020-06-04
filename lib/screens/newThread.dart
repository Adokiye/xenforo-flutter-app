import 'package:flutter/material.dart';
import 'package:xenforo/helpers/key.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:xenforo/components/loader.dart';
import 'package:xenforo/components/buttons/fullButton/index.dart';
import 'package:flutter/services.dart';
import 'package:xenforo/screens/home.dart';
import 'package:provider/provider.dart';
import 'package:xenforo/providers/user.dart';

class NewThread extends StatefulWidget {
  final String title;
  NewThread({Key key, @required this.id,@required this.title}) : super(key: key);
  final int id;

  @override
  _NewThreadState createState() => _NewThreadState();
}

class _NewThreadState extends State<NewThread> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  String _title;
  String _message;
  Future<dynamic> newThread;
  bool _showLoader = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

   Future<dynamic> postThread() async {
    _showLoader = true;
    print(apiKey);
    final response = await http.post(
      url + 'threads/'+'?title='+_title+
      '&node_id='+widget.id.toString()+'&message='+_message,
      headers: <String, String>{
        'XF-Api-Key': apiKey,
        'XF-Api-User': Provider.of<UserModel>(context, listen: false).id,
        'Content-Type': 'application/x-www-form-urlencoded',
      },
    );
    print(response.body.toString());
    if (response.statusCode == 200) {
      setState((){
         _showLoader = false;
      });
     
      // If the server did return a 200 OK response,
      // then parse the JSON.
                      _scaffoldKey.currentState.showSnackBar(
  SnackBar(
    content: Text('Thread Created Successfully', 
    style: TextStyle(fontSize: 15.0, 
    color: Colors.white, fontWeight: FontWeight.w300, ))
    ,
    behavior: SnackBarBehavior.floating,
    backgroundColor: Color(0xff1281dd),
    elevation: 0.0,
  ));
        Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => MyHomePage(
          ),
        ),
        (Route<dynamic> route) => false
      );
    } else {
       setState((){
         _showLoader = false;
      });
      // If the server did not return a 200 OK response,
      // then throw an exception.
                   _scaffoldKey.currentState.showSnackBar(
  SnackBar(
    content: Text('Failed to post thread', 
    style: TextStyle(fontSize: 15.0, 
    color: Colors.white, fontWeight: FontWeight.w300, ))
    ,
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
            margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.03),
            child: FullButton(
              isWhite: false,
              title: 'POST',
              onPressed: post,
            ))
      ],
    );
  }
}
