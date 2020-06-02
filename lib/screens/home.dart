import 'package:flutter/material.dart';
import 'package:xenforo/components/briefForumBox/index.dart';
import 'package:xenforo/models/forum.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:xenforo/helpers/key.dart';
import 'package:page_transition/page_transition.dart';
import 'package:xenforo/screens/conversations.dart';
import 'package:xenforo/components/emptyData/index.dart';
import 'package:xenforo/components/loader.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey _scaffoldKey = new GlobalKey();
  Future<dynamic> futureForums;
  List<Forum> forums;

  Future<dynamic> fetchForums() async {
    final response = await http.get(
      url + 'nodes',
      headers: <String, String>{
        'XF-Api-Key': apiKey,
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      // body: jsonEncode(<String, String>{
      //   'title': title,
      // }),
    );
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      print(json
          .decode(response.body)['nodes']);
      List<Forum> tester = List();
      for(var i =0;i<json.decode(response.body)['nodes'].length;i++){
       tester.add(Forum.fromMap(json
          .decode(response.body)['nodes'][i]));
      }
      return tester;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load forums');
    }
  }

  @override
  void initState() {
    super.initState();
    futureForums = fetchForums();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.menu,
            color: Colors.white,
          ),
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
        ),
        actions: <Widget>[
          new IconButton(
            icon: new Icon(
              Icons.search,
              color: Colors.white,
            ),
            onPressed: () => {},
          ),
        ],
        title: Text('Xenforo Forum'),
      ),
      body: FutureBuilder(
          future: futureForums,
          builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.none &&
            snapshot.hasData == null) {
              //print('project snapshot data is: ${projectSnap.data}');
              return EmptyData(title: 'Forums');
            }
            if (snapshot.hasData) {
             // print(jsonDecode(snapshot.data[0]));
              return new ListView.builder(
                itemBuilder: (BuildContext context, int index){
               //   print(Forum(title: snapshot.data));
                 return new BriefForumBox(
                  forumData: snapshot.data[index]);
                },
                itemCount: snapshot.data.length,
                shrinkWrap: true,
              );
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            // By default, show a loading   spinner.
            return Loader();  
          },
        ),
      
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.symmetric(vertical:10.0),
          children: <Widget>[
            DrawerHeader(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: Center(
                child: Text('Xenforo Forum', 
                style: TextStyle(color: Colors.white, fontSize: 16.0),
                
                )),
              decoration: BoxDecoration(
             //   color: Colors.blue,
              ),
            ),
            ListTile(
              title: Text('Forums', style: TextStyle(fontSize: 14.0),),
              onTap: () {
                Navigator.pop(context);
              },
            ),
              ListTile(
              title: Text('Conversations', style: TextStyle(fontSize: 14.0),),
              onTap: () {
                      Navigator.push(
                                            context,
                                            PageTransition(
                                                type: PageTransitionType
                                                    .rightToLeft,
                                                child: Conversations()));
              },
            ),
             ListTile(
              title: Text('Log out', style: TextStyle(fontSize: 14.0),),
              onTap: () {
                    
              },
            ),
          ],
        ),
      ),
    );
  }
}
