import 'package:flutter/material.dart';
import 'package:mdi/mdi.dart';
import 'package:provider_arc/ui/shared/app_colors.dart';

class FromTo extends StatelessWidget {
  final String from;
  final String to;

  const FromTo({Key key, this.from, this.to}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          ListTile(
            dense: true,
            contentPadding: EdgeInsets.only(left: 16.0, right: 0.0),
            leading: Icon(
              Icons.near_me,
              color: PrimaryColor,
            ),
            title: Text(
              "Pick up location",
              style: TextStyle(color: Grey),
            ),
            subtitle: Text(
              from,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 60),
            child: Divider(
              height: 1,
            ),
          ),
          ListTile(
            dense: true,
            contentPadding: EdgeInsets.only(left: 16.0, right: 0.0),
            leading: Icon(
              Mdi.mapMarker,
              color: PrimaryColor,
            ),
            title: Text(
              "Destination location",
              style: TextStyle(color: Grey),
            ),
            subtitle: Text(
              to,
            ),
          ),
        ],
      ),
    );
  }
}
