import 'package:flutter/material.dart';

class MyTitle extends StatelessWidget {
  final String title;

  const MyTitle({Key key, this.title}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
    );
  }
}
