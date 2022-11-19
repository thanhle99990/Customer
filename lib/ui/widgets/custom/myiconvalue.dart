import 'package:flutter/material.dart';
import 'package:provider_arc/ui/shared/ui_helpers.dart';

class MyIconValue extends StatelessWidget {
  final IconData icon;
  final String title;

  const MyIconValue({Key key, this.title, this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon),
        UIHelper.horizontalSpaceSmall,
        Text(
          title == null ? '' : title,
        ),
      ],
    );
  }
}
