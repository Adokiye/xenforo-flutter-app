import 'package:flutter/material.dart';

class Loader extends StatefulWidget {  
  final String title;
  Loader({Key key, this.title}) : super(key: key);


  @override
  _LoaderState createState() => _LoaderState();
}

class _LoaderState extends State<Loader> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
    backgroundColor: Colors.cyanAccent,
    valueColor: new AlwaysStoppedAnimation<Color>(Color(0xff1281dd)),
  )
    );
  }
}



