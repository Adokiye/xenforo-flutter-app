import 'package:flutter/material.dart';
import 'package:xenforo/models/forumContent.dart';

class ThreadHeader extends StatefulWidget {
    final ForumContent forumData;
  ThreadHeader({
    @required this.forumData
  });
  @override
  _ThreadHeaderState createState() {
    return _ThreadHeaderState();
  }
}

class _ThreadHeaderState extends State<ThreadHeader> {

  @override
  Widget build(BuildContext context) {
    return new 
    Center(
      child: Container(
      width: MediaQuery.of(context).size.width * 0.90,
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
          children:<Widget>[
            Container(
              margin: EdgeInsets.only(right: 10.0),
              child:   Icon(Icons.event,size: 16.0,
            color: Color(0xff1281dd),),
            ),
            new Text(
        DateTime.fromMicrosecondsSinceEpoch(widget.forumData.date).day.toString()+'-'+
        DateTime.fromMicrosecondsSinceEpoch(widget.forumData.date).month.toString()+'-'+
        DateTime.fromMicrosecondsSinceEpoch(widget.forumData.date).year.toString()
        , style: TextStyle(color: Colors.black, fontSize: 16.0),),
        Spacer(),
         Container(
              margin: EdgeInsets.only(right: 10.0),
              child:   Icon(Icons.visibility,size: 16.0,
            color: Color(0xff1281dd),),
            ),
            new Text(
        widget.forumData.viewCount.toString()
        , style: TextStyle(color: Colors.black, fontSize: 16.0),),
         Spacer(),
         Container(
              margin: EdgeInsets.only(right: 10.0),
              child:   Icon(Icons.textsms,size: 16.0,
            color: Color(0xff1281dd),),
            ),
            new Text(
        widget.forumData.replyCount.toString()
        , style: TextStyle(color: Colors.black, fontSize: 16.0),),
        ]),
      
    ));
  }
}
