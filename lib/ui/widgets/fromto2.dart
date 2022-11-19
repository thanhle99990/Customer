import 'package:flutter/material.dart';
import 'package:provider_arc/ui/shared/app_colors.dart';

class FromTo2 extends StatelessWidget {
  final String from;
  final String to;

  const FromTo2({Key key, this.from, this.to}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              color: Colors.white,
              child: ListTile(
                  leading: Icon(
                    Icons.radio_button_checked,
                    color: PrimaryColor,
                  ),
                  title: GestureDetector(
                    onTap: () => {},
                    child: Text(
                      "$from",
                      textAlign: TextAlign.start,
                      style: TextStyle(color: Colors.black),
                    ),
                  )),
            ),
          ),
          Container(
            height: 1,
            color: LightColor,
            margin: EdgeInsets.only(left: 80, right: 20),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              color: Colors.white,
              child: ListTile(
                  leading: Icon(
                    Icons.crop_square,
                    color: Dark,
                  ),
                  title: Text(
                    "$to",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
