import 'package:flutter/material.dart';

class ItemOrderPrice extends StatelessWidget {
  final String title;
  final IconData icon;
  ItemOrderPrice({Key key, this.title, this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            icon,
            // size: 35,
          ),
          SizedBox(
            width: 6,
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 15,
            ),
          ),
        ],
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
