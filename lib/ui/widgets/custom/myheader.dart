import 'package:flutter/material.dart';
import 'package:provider_arc/ui/shared/text_styles.dart';

class SubHeader extends StatelessWidget {
  final String title;

  const SubHeader({Key key, this.title}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          Text(title, style: subHeaderStyle),
        ],
      ),
    );
  }
}
