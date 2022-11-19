import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';

class Nodata extends StatelessWidget {
  //final String title;

  //Nodata(this.title) ;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Icon(
            CupertinoIcons.bell,
            color: Colors.grey,
            size: 70,
          ),
          Text(
            "No data found",
            style: TextStyle(color: Colors.grey),
          )
        ],
      ),
    );
  }
}
