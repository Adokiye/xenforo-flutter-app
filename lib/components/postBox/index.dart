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
                backgroundColor: Color(0xff1281dd),
                // backgroundImage: AssetImage(
                //   "${widget.dp}",
                // ),
                child: Icon(Icons.account_circle, size: 28.0,),
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
              title: Text(
                "${widget.post.user.username}",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              trailing: Text(
                   DateTime.fromMicrosecondsSinceEpoch(widget.post.date).day.toString()+'-'+
        DateTime.fromMicrosecondsSinceEpoch(widget.post.date).month.toString()+'-'+
        DateTime.fromMicrosecondsSinceEpoch(widget.post.date).year.toString(),
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: 11,
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(top: 5.0),
              padding: EdgeInsets.only(bottom: 5.0,left: 10.0,right:10.0),
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(width: 1.0, color: Color(0xffc4c4c4)))),
                   child: Text(widget.post.message, textAlign: TextAlign.justify,
                   style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400),)
              ),
            // Image.asset(
            //   "${widget.img}",
            //   height: 170,
            //   width: MediaQuery.of(context).size.width,
            //   fit: BoxFit.cover,
            // ),

          ],
        ),
        onTap: (){},
      ),
    );
  }
}



