import 'package:flutter/material.dart';
import 'package:xenforo/models/forumContent.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:xenforo/helpers/key.dart';
import 'package:xenforo/models/post.dart';
import 'package:xenforo/components/threadHeader/threadHeader.dart';
import 'package:xenforo/components/buttons/fullButton/index.dart';
import 'package:xenforo/components/postBox/index.dart';
import 'package:xenforo/components/emptyData/index.dart';
import 'package:xenforo/components/loader.dart';
import 'package:xenforo/components/buttons/floatingButton.dart';
import 'package:page_transition/page_transition.dart';
import 'package:xenforo/screens/newPost.dart';

class ThreadInfo extends StatefulWidget {
  final int id;
  final ForumContent forumData;
  ThreadInfo({Key key, this.title, this.id, this.forumData}) : super(key: key);

  final String title;

  @override
  _ThreadInfoState createState() => new _ThreadInfoState();
}

class _ThreadInfoState extends State<ThreadInfo> {
  final GlobalKey _scaffoldKey = new GlobalKey();
  Future<dynamic> futurePosts;
  List<Post> posts;

  Future<dynamic> fetchThreadInfo() async {
    final response = await http.get(
      url + 'threads/' + widget.id.toString() + '/posts',
      headers: <String, String>{
        'XF-Api-Key': apiKey,
        'Content-Type': 'application/x-www-form-urlencoded',
      },
    );
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      print(json.decode(response.body)['posts']);
      List<Post> tester = List();
      for (var i = 0; i < json.decode(response.body)['posts'].length; i++) {
        tester.add(Post.fromMap(json.decode(response.body)['posts'][i]));
      }
      return tester;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load posts');
    }
  }

  @override
  void initState() {
    super.initState();
    futurePosts = fetchThreadInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: <Widget>[
          new IconButton(
            icon: new Icon(
              Icons.search,
              color: Colors.white,
            ),
            onPressed: () => {},
          ),
        ],
        title: Text(widget.title),
      ),
      body: FutureBuilder(
        future: futurePosts,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.none &&
              snapshot.hasData == null) {
            //print('project snapshot data is: ${projectSnap.data}');
            return EmptyData(title: 'Posts for ' + widget.title);
          }
          if (snapshot.hasData) {
            // print(jsonDecode(snapshot.data[0]));
            return new Stack(children: <Widget>[
              Column(children: <Widget>[
                ThreadHeader(forumData: widget.forumData),
                ListView.builder(
                  itemBuilder: (BuildContext context, int index) {
                    //   print(Post(title: snapshot.data));
                    return new PostBox(post: snapshot.data[index]);
                  },
                  itemCount: snapshot.data.length,
                  shrinkWrap: true,
                )
              ]),
            ]);
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          // By default, show a loading spinner.
          return Loader();
        },
      ),
      floatingActionButton: FloatingButton(
        onPressed: () {
          Navigator.push(
              context,
              PageTransition(
                  type: PageTransitionType.rightToLeft,
                  child: NewPost(
                    title: widget.forumData.title,
                    id: widget.forumData.id,
                    forumData: widget.forumData,
                  )));
        },
      ),
    );
  }
}
