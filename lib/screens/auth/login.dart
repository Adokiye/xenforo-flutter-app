import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:xenforo/helpers/key.dart';
import 'package:xenforo/models/user.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:xenforo/components/loader.dart';
import 'package:flutter/services.dart';
import 'package:xenforo/components/buttons/fullButton/index.dart';
import 'package:xenforo/screens/home.dart';
import 'package:xenforo/screens/auth/signup.dart';
import 'package:provider/provider.dart';
import 'package:xenforo/providers/user.dart';

class Login extends StatefulWidget {
  Login({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _LoginState createState() => _LoginState();
}
//iamf//abinne
class _LoginState extends State<Login> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  String _username;
  String _password;
  bool _showLoader = false;
  // Initially password is obscure
  bool _obscureText = true;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  // Toggles the password show status
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

    Future<dynamic> login() async {
    _showLoader = true;
    final response = await http.post(
      url + 'auth?login='+_username+
      '&password='+_password,
      headers: <String, String>{
        'XF-Api-Key': apiKey,
        'Content-Type': 'application/x-www-form-urlencoded',
      },
    );
    if (response.statusCode == 200) {
     var userId =  User.fromMap(json.decode(response.body)['user']).id;
         Provider.of<UserModel>(context,listen: false).setId(userId.toString());
       setState((){
         _showLoader = false;
      });
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text('Login Successful',
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
                MyHomePage(),
          ),
          (Route<dynamic> route) => false);
    } else {
      setState((){
         _showLoader = false;
      });
      // If the server did not return a 200 OK response,
      // then throw an exception.
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text('Error',
            style: TextStyle(
              fontSize: 15.0,
              color: Colors.white,
              fontWeight: FontWeight.w300,
            )),
        action: SnackBarAction(label: 'RETRY', onPressed: login),
        //  behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.red,
        elevation: 0.0,
      ));
      //throw Exception('Failed to load post thread');
    }
  }

   void post() {
    if (_formKey.currentState.validate()) {
//    If all data are correct then save data to our variables
      _formKey.currentState.save();
      login();
    } else {
//    If all data are not valid then start auto validation.
      setState(() {
        _autoValidate = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {   
     final appState = Provider.of<UserModel>(context);
    return Scaffold(
            key: _scaffoldKey,
      backgroundColor: Color(0xff1281dd),
       body: new SingleChildScrollView(
        child: new Container(
          margin: new EdgeInsets.all(15.0),
          child: new Form(
            key: _formKey,
            autovalidate: _autoValidate,
            child: customForm(),
          ),
        ),
      ),);
  }

    Widget customForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        _showLoader ? Loader() : Container(),
        Text('Log In', 
        style: TextStyle(color: Colors.white,
        fontSize: 22)),
        new Container(
            margin:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.03),
            width: MediaQuery.of(context).size.width * 0.90,
            decoration: BoxDecoration(
              color: Color(0xff1281dd).withOpacity(0.80),
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
                border: Border.all(color: Colors.white.withOpacity(0.25))),
            child: new TextFormField(
              decoration: new InputDecoration(
                labelText: "Username",
                fillColor: Colors.white,
                hintText: 'Enter your username',
                hintStyle: TextStyle(
                  fontSize: 13.0,
                  color: const Color(0xffC4C4C4),
                ),
                border: InputBorder.none,
              ),
              validator: (val) {
                if (val.length == 0) {
                  return "Username is required";
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
                _username= val;
              },
            )),
             new Container(
            margin:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.03),
            width: MediaQuery.of(context).size.width * 0.90,
            decoration: BoxDecoration(
              color: Color(0xff1281dd).withOpacity(0.80),
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
                border: Border.all(color: Colors.white.withOpacity(0.25))),
            child: new TextFormField(
                keyboardType: TextInputType.text,
                obscureText: _obscureText,
              decoration: new InputDecoration(
                labelText: "Password",
                fillColor: Colors.white,
                hintText: 'Enter your password',
                hintStyle: TextStyle(
                  fontSize: 13.0,
                  color: const Color(0xffC4C4C4),
                ),
                border: InputBorder.none,
                   suffixIcon: IconButton(
            icon: Icon(
              // Based on passwordVisible state choose the icon
               _obscureText
               ? Icons.visibility
               : Icons.visibility_off,
               color: Theme.of(context).primaryColorDark,
               ),
            onPressed: _toggle,
            ),
              ),
              validator: (val) {
                if (val.length == 0) {
                  return "Password is required";
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
                _password = val;
              },
            )),
              
        Container(
            margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.03),
            child: FullButton(
              isWhite: false,
              title: 'LOG IN',
              onPressed: post,
            )),
             new Container(
            margin:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.03),
               
               child: Center(
                 child: Material(
                   child: InkWell(
                     onTap: (){          Navigator.push(
          context,
          PageTransition(
              type: PageTransitionType
                  .rightToLeft,
              child: SignUp()));},
              child: Text('SIGN UP', style: TextStyle(color: Colors.white, fontSize: 16.0, fontWeight: FontWeight.w700)),
                   )
                 )
               ))
      ],
    );
  }

}
