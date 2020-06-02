import 'package:flutter/material.dart';

class FullButton extends StatefulWidget {
  final String title;
  final GestureTapCallback onPressed;
  FullButton({Key key, @required this.title, @required this.onPressed}) : super(key: key);
  @override
  _FullButtonState createState() => _FullButtonState();
}

class _FullButtonState extends State<FullButton> {
  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        shape: RoundedRectangleBorder(
  borderRadius: BorderRadius.circular(5.0),
  // side: BorderSide(color: Colors.red)
),
      color: Color(0xff1281dd),
      child: InkWell(
        onTap: widget.onPressed,
        child: Container(
          width: MediaQuery.of(context).size.width*0.90,
          padding: EdgeInsets.symmetric(vertical: 10.0),
          child: Center(
            child: Text(widget.title, style: TextStyle(color: Colors.white,fontSize: 16.0, fontWeight: FontWeight.w700),),
          )
        ),
      )
     ) );
  }
}



