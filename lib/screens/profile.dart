import 'package:flutter/material.dart';
import 'package:xenforo/components/threadForumBox/index.dart';
import 'package:xenforo/models/user.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:xenforo/helpers/key.dart';
import 'package:xenforo/components/emptyData/index.dart';
import 'package:xenforo/components/loader.dart';
import 'package:xenforo/components/buttons/floatingButton.dart';
import 'package:page_transition/page_transition.dart';
import 'package:xenforo/screens/newThread.dart';
import 'package:provider/provider.dart';
import 'package:xenforo/providers/user.dart';
import 'package:xenforo/screens/auth/login.dart';

class Profile extends StatefulWidget {
  Profile({
    Key key,
  }) : super(key: key);

  @override
  _ProfileState createState() => new _ProfileState();
}

class _ProfileState extends State<Profile> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  Future<User> futureProfile;
  User user;

  Future<User> fetchProfile() async {
    final response = await http.get(
      url +
          'users/' +
          Provider.of<UserModel>(context, listen: false).id.toString(),
      headers: <String, String>{
        'XF-Api-Key': apiKey,
        'XF-Api-User': Provider.of<UserModel>(context, listen: false).id,
        'Content-Type': 'application/x-www-form-urlencoded',
      },
    );
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      print(json.decode(response.body)['user']);
      user = User.fromMap(json.decode(response.body)['user']);
      return user;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text('Failed to load profile',
            style: TextStyle(
              fontSize: 15.0,
              color: Colors.white,
              fontWeight: FontWeight.w300,
            )),
        action: SnackBarAction(
            label: 'RETRY',
            onPressed: () {
              fetchProfile();
            }),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.red,
        elevation: 0.0,
      ));
      //  throw Exception('Failed to load forums');
    }
  }

  @override
  void initState() {
    super.initState();
    futureProfile = fetchProfile();
  }

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<UserModel>(context);
    if (appState.id != '') {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text('You\'re not logged in',
            style: TextStyle(
              fontSize: 15.0,
              color: Colors.white,
              fontWeight: FontWeight.w300,
            )),
        action: SnackBarAction(
            label: 'LOGIN',
            onPressed: () {
              Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.rightToLeftWithFade,
                      child: Login()));
            }),
        behavior: SnackBarBehavior.floating,
        elevation: 0.0,
      ));
    }
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Text(user.username != '' ? user.username : 'Profile',
            style: TextStyle(color: Colors.black, fontSize: 16.0)),
      ),
      body: FutureBuilder(
        future: futureProfile,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.none &&
              snapshot.hasData == null) {
            //print('project snapshot data is: ${projectSnap.data}');
            return EmptyData(title: 'Profile');
          }
          if (snapshot.hasData) {
            return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(bottom: 10.0),
                    padding:
                        EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                      colors: [
                        Color(0xff1281dd),
                        Color(0xff1281dd).withOpacity(0.25)
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    )),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            child: Icon(Icons.account_circle,
                                size: 50.0, color: Colors.white),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 10.0),
                            child: Text(
                              snapshot.data.username,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22.0,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                          SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 50),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                   Column(
      children: <Widget>[
        Text(
          snapshot.data.messageCount,
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 22,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 4),
        Text(
          'MESSAGES',
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 22,
            color: Colors.black,
          ),
        ),
      ],
    ),
                   Column(
      children: <Widget>[
        Text(
          snapshot.data.reactionScore,
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 22,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 4),
        Text(
          'REACTIONS',
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 22,
            color: Colors.black,
          ),
        ),
      ],
    ),
                  ],
                ),
              ),
                        ]),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.03),
                    width: MediaQuery.of(context).size.width * 0.90,
                    child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        color: Colors.white,
                        elevation: 5.0,
                        child: ListTile(
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 10.0),
                          title: Text('BIO',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14.0)),
                          subtitle: Text(snapshot.data.about,
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14.0)),
                        )),
                  )
                ]);
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          // By default, show a loading spinner.
          return Loader();
        },
      ),
    );
  }
}
