import 'package:flutter/material.dart';
import 'package:provider_arc/core/utils/device_utils.dart';
import 'package:provider_arc/ui/shared/app_colors.dart';

class MyButton extends StatelessWidget {
  final String caption;
  final GestureTapCallback onPressed;
  final bool fullsize;

  MyButton({Key key, this.caption, this.onPressed, this.fullsize})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return fullsize
        ? SizedBox(
            width: double.infinity,
            child: FlatButton(
              shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(14.0)),
              color: PrimaryColor,
              textColor: Colors.white,
              disabledColor: Colors.grey,
              disabledTextColor: Colors.black,
              padding: EdgeInsets.fromLTRB(24, 14, 24, 14),
              //splashColor: Basic,
              onPressed: onPressed,
              child: Text(
                caption,
                style: TextStyle(fontSize: 20.0),
              ),
            ),
          )
        : SizedBox(
            width: DeviceUtils.getScaledWidth(context, 1 / 3),
            child: FlatButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14.0)),
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
