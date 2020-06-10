import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ButtonStandard extends StatefulWidget {
  @override
  _ButtonStandardState createState() => _ButtonStandardState();
  double _width;
  double _height;
  String _text;
  VoidCallback _voidCallback;
  ButtonStandard(
      {@required String text,
      double width = 200,
      @required VoidCallback voidCallback,
      double height = 40}) {
    this._width = width;
    this._height = height;
    this._voidCallback = voidCallback;
    this._text = text;
  }
}

class _ButtonStandardState extends State<ButtonStandard> {
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget._width,
      height: widget._height,
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(10.0),
        ),
        child: Text(
          widget._text,
          style: GoogleFonts.b612(fontSize: 30),
        ),
        onPressed: widget._voidCallback,
      ),
    );
  }
}
