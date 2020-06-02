import 'package:flutter/material.dart';
import 'package:xenforo/models/forumContent.dart';
import 'package:page_transition/page_transition.dart';
import 'package:xenforo/screens/threadInfo.dart';

class ThreadForumBox extends StatefulWidget {
    final ForumContent forumData;
  ThreadForumBox({
    @required this.forumData
  });
  @override
  _ThreadForumBoxState createState() {
    return _ThreadForumBoxState();
  }
}

class _ThreadForumBoxState extends State<ThreadForumBox> {

  @override
  Widget build(BuildContext context) {
    return new Container(
      padding: const EdgeInsets.all(3.0),
      margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 3.0),
      decoration: new BoxDecoration(
        borderRadius: new BorderRadius.all(new Radius.circular(15.0)),
        color: Colors.white,
         boxShadow: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.5),
        spreadRadius: 5,
        blurRadius: 7,
        offset: Offset(0, 3), // changes position of shadow
      ),
    ],
  //      border: Border.all(color: const Color(0xff1281dd), width: 1.0),
      ),
      child: new ListTile(
        title: new Text(widget.forumData.title, style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 16.0)),
        subtitle: Row(
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
             Spacer(),
         Container(
              margin: EdgeInsets.only(right: 10.0),
              child:   Icon(Icons.face,size: 16.0,
            color: Color(0xff1281dd),),
            ),
            new Text(
        widget.forumData.user.username.toString()
        , style: TextStyle(color: Colors.black, fontSize: 16.0),),
        ]),
        // leading: new Icon(
        //   Icons.add_circle,
        //   color: Colors.black,
        // ),
        trailing: new Icon(
          Icons.arrow_forward_ios,
          color: const Color(0xff1281dd),
        ),
          onTap: () {
          Navigator.push(
          context,
          PageTransition(
              type: PageTransitionType
                  .rightToLeft,
              child: ThreadInfo(title: widget.forumData.title,
              id:widget.forumData.id, forumData: widget.forumData,)));
        },
      ),
    );
  }
}
