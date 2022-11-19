import 'package:flutter/material.dart';
import 'package:provider_arc/ui/shared/app_colors.dart';

class RadioItemRow extends StatelessWidget {
  final RadioModelRow item;
  final GestureTapCallback onPressed;

  RadioItemRow({Key key, this.item, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Card(
        child: ListTile(
          leading: Image.asset(item.img),
          title: Text(item.numbercode),
          subtitle: Text(item.more),
          trailing: (item.isSelected)
              ? Icon(
                  Icons.check_box,
                  color: PrimaryColor,
                )
              : null,
        ),
      ),
    );
  }
}

class RadioModelRow {
  bool isSelected;
  String numbercode;
  String img;
  String more;

  RadioModelRow(this.isSelected, this.img, this.numbercode, this.more);
}
