import 'package:flutter/material.dart';

class FloatingButton extends StatefulWidget {
  final GestureTapCallback onPressed;
  FloatingButton({Key key, @required this.onPressed}) : super(key: key);


  @override
  _FloatingButtonState createState() => _FloatingButtonState();
}

class _FloatingButtonState extends State<FloatingButton> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
           backgroundColor: Color(0xff1281dd),
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: widget.onPressed,
      );
  }
}



