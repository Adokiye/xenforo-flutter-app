import 'package:flutter/material.dart';

class EmptyData extends StatefulWidget {  
  final String title;
  EmptyData({Key key, @required this.title}) : super(key: key);


  @override
  _EmptyDataState createState() => _EmptyDataState();
}

class _EmptyDataState extends State<EmptyData> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(child: Text('No ${widget.title} available yet.', 
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black,
              fontSize: 28.0, fontWeight: FontWeight.w400),));
  }
}



