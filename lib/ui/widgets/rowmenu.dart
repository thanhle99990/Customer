import 'package:flutter/material.dart';
import 'package:provider_arc/ui/shared/app_colors.dart';

class RowMenu extends StatelessWidget {
  final IconData icon;
  final String title;

  const RowMenu({Key key, this.icon, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => {
        //goto(goid)
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 5.0),
        child: Row(children: [
          Icon(
            icon,
            //color: active,
          ),
          SizedBox(width: 10.0),
          Text(
            title,
            //style: tStyle,
          ),
          Spacer(),
          Material(
            color: PrimaryColor,
            elevation: 5.0,
            shadowColor: Colors.red,
            borderRadius: BorderRadius.circular(5.0),
            child: Container(
              width: 25,
              height: 25,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: PrimaryColor,
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: Text(
                "3",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold),
              ),
            ),
          )
        ]),
      ),
    );
  }
}
