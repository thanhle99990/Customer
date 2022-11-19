import 'package:flutter/material.dart';

class MyDivider extends StatelessWidget {
  const MyDivider({
    Key key,
  }) : super(key: key);

  final Color divider = Colors.grey;

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: divider,
    );
  }
}
