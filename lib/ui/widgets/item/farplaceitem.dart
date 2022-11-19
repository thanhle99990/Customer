import 'package:flutter/material.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:provider_arc/core/models/placeobj.dart';
import 'package:provider_arc/ui/shared/app_colors.dart';
import 'package:provider_arc/ui/widgets/dummy.dart';

class FarPlaceItem extends StatelessWidget {
  const FarPlaceItem({
    Key key,
    @required this.obj,
    this.enable,
    this.onPressed,
  }) : super(key: key);

  final PlaceObj obj;
  final bool enable;
  final GestureTapCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 5),
        child: ListTile(
          leading: obj.type == 0
              ? Icon(
                  LineAwesomeIcons.home,
                  color: Colors.black,
                )
              : obj.type == 1
                  ? Icon(
                      LineAwesomeIcons.briefcase,
                      color: Colors.black,
                    )
                  : obj.type == 3
                      ? Icon(
                          LineAwesomeIcons.history,
                          color: Colors.black,
                        )
                      : Icon(
                          LineAwesomeIcons.map_marker,
                          color: Colors.black,
                        ),
          title: Text(obj.name == null ? '' : obj.name),
          subtitle: Text(obj.address),
          trailing: enable
              ? Icon(
                  LineAwesomeIcons.minus_circle,
                  color: Dark,
                )
              : Dummy(),
        ),
      ),
    );
  }
}
