import 'package:flutter/material.dart';

class BorderButton extends StatefulWidget {
  final String title;
  final GestureTapCallback onPressed;
  BorderButton({Key key, @required this.title, @required this.onPressed}) : super(key: key);

  @override
  _BorderButtonState createState() => _BorderButtonState();
}

class _BorderButtonState extends State<BorderButton> {
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
   side: BorderSide(color: Color(0xff1281dd))
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



