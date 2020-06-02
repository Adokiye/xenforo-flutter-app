import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:xenforo/helpers/key.dart';
import 'package:xenforo/models/post.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class PostBox extends StatefulWidget {
  final Post post;
  PostBox({Key key, this.title, @required this.post}) : super(key: key);
  final String title;

  @override
  _PostBoxState createState() => _PostBoxState();
}

class _PostBoxState extends State<PostBox> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: InkWell(
        child: Column(
          children: <Widget>[
            ListTile(
              leading: CircleAvatar(
                // backgroundImage: AssetImage(
                //   "${widget.dp}",
                // ),
                child: Icon(Icons.account_circle, size: 12.0,),
              ),
              contentPadding: EdgeInsets.all(0),
              title: Text(
                "${widget.post.user.username}",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              trailing: Text(
                   DateTime.fromMicrosecondsSinceEpoch(widget.post.date).day.toString()+'-'+
        DateTime.fromMicrosecondsSinceEpoch(widget.post.date).month.toString()+'-'+
        DateTime.fromMicrosecondsSinceEpoch(widget.post.date).year.toString()
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: 11,
                ),
              ),
            ),

            Image.asset(
              "${widget.img}",
              height: 170,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
            ),

          ],
        ),
        onTap: (){},
      ),
    );
  }
}



