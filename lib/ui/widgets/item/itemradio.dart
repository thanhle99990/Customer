import 'package:flutter/material.dart';
import 'package:provider_arc/ui/shared/app_colors.dart';

class RadioItem extends StatelessWidget {
  final RadioModel item;
  final GestureTapCallback onPressed;

  //RadioItem(this._item, this.onPressed);
  RadioItem({Key key, this.item, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FlatButton(
        onPressed: onPressed,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              item.icon,
              color: item.isSelected ? PrimaryColor : Colors.grey[500],
              size: 35,
            ),
            Text(
              item.time,
              style: TextStyle(
                fontSize: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RadioModel {
  bool isSelected;
  String time;
  IconData icon;

  RadioModel(this.isSelected, this.time, this.icon);
}
