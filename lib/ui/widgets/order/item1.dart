import 'package:flutter/material.dart';
import 'package:provider_arc/ui/shared/app_colors.dart';

class Item1 extends StatelessWidget {
  final IconData icon;
  final String text;

  const Item1({Key key, this.icon, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(12.0)),
            child: Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Icon(
                    icon,
                    size: 16,
                    color: PrimaryColor,
                  ),
                ))),
        SizedBox(
          width: 4,
        ),
        Text(
          text,
          //style: TextStyle(fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}
