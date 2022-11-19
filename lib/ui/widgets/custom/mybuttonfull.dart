import 'package:flutter/material.dart';
import 'package:provider_arc/ui/shared/app_colors.dart';

class MyButtonFull extends StatelessWidget {
  final String caption;
  final GestureTapCallback onPressed;

  MyButtonFull({Key key, this.caption, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: FlatButton(
        shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(0.0)),
        color: PrimaryColor,
        textColor: Colors.white,
        disabledColor: Colors.grey,
        disabledTextColor: Colors.black,
        padding: EdgeInsets.fromLTRB(24, 12, 24, 12),
        //splashColor: Basic,
        onPressed: onPressed,
        child: Text(
          caption,
          style: TextStyle(fontSize: 20.0),
        ),
      ),
    );
  }
}
