import 'package:flutter/material.dart';
import 'package:xenforo/models/forum.dart';
import 'package:xenforo/screens/forumThread.dart';
import 'package:page_transition/page_transition.dart';

class BriefForumBox extends StatefulWidget {
    final Forum forumData;
  BriefForumBox({
    @required this.forumData
  });
  @override
  _BriefForumBoxState createState() {
    return _BriefForumBoxState();
  }
}

class _BriefForumBoxState extends State<BriefForumBox> {

  @override
  Widget build(BuildContext context) {
    print(widget.forumData.description);
    return new Container(
      padding: const EdgeInsets.all(3.0),
      margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 3.0),
      decoration: new BoxDecoration(
        borderRadius: new BorderRadius.all(new Radius.circular(15.0)),
        color: Color(0xff1281dd),
      ),
      child: new ListTile(
        title: new Text(widget.forumData.title, style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 16.0),),
        subtitle: new Text(widget.forumData.description, style: TextStyle(color: Colors.white),),
        leading: new Icon(
          Icons.apps,
          color: Colors.white,
        ),
        trailing: new Icon(
          Icons.arrow_forward_ios,
          color: Colors.white,
        ),
        onTap: () {
          Navigator.push(
                                            context,
                                            PageTransition(
                                                type: PageTransitionType
                                                    .rightToLeft,
                                                child: ForumThread(title: widget.forumData.title,
                                                id:widget.forumData.id)));
        },
      ),
    );
  }
}
