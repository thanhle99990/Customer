import 'package:flutter/material.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:provider_arc/core/models/notification.dart';
import 'package:provider_arc/ui/shared/app_colors.dart';
import 'package:provider_arc/ui/shared/text_styles.dart';

class ItemNotification extends StatelessWidget {
  final NotifyObj item;
  ItemNotification({Key key, this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListTile(
      leading: Icon(
        LineAwesomeIcons.bell_o,
        color: PrimaryColor,
      ),
      title: Text(item.title, style: TitleStyle,),
      subtitle: Text(item.message),
      trailing: Text(item.date),
    );
  }
}
