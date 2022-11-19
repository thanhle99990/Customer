import 'package:flutter/material.dart';
import 'package:provider_arc/ui/shared/app_colors.dart';

class MyButtonCicle extends StatelessWidget {
  final IconData icon;
  final GestureTapCallback onPressed;

  const MyButtonCicle({Key key, this.icon, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      color: Colors.white,
      child: Icon(
        icon,
        color: PrimaryColor,
      ),
      shape: CircleBorder(),
    );
  }
}
