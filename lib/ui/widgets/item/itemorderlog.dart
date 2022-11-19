import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:provider_arc/core/models/order.dart';
import 'package:provider_arc/core/utils/device_utils.dart';
import 'package:provider_arc/ui/shared/text_styles.dart';
import 'package:provider_arc/ui/shared/ui_helpers.dart';
import 'package:provider_arc/ui/widgets/fromto.dart';

class ItemOrderlog extends StatelessWidget {
  final OrderObj item;

  const ItemOrderlog({Key key, this.item}) : super(key: key);

  /* Widget _buidstatus(String status) {
    DriverStatus driverStatus = EnumToString.fromString(DriverStatus.values, status);
    return driverStatus == DriverStatus.booked
        ? Chip(backgroundColor: Colors.yellow, label: Text('Waiting '))
        : driverStatus == DriverStatus.completed
            ? Chip(backgroundColor: Colors.green, label: Text('Completed '))
            : driverStatus == DriverStatus.cancel
                ? Chip(backgroundColor: Colors.red, label: Text('Cancel '))
                : Chip(backgroundColor: Colors.yellow, label: Text('Other '));
  }*/

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text(
              item.id.toString(),
              style: BoldStyle,
            ),
            //trailing: _buidstatus(item.driverstatus),
          ),
          Dash(
            length: DeviceUtils.getScaledWidth(context, 1) - 40,
            dashColor: Colors.grey,
          ),
          UIHelper.verticalSpaceSmall,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                /*SmallItem(
                  icon: LineAwesomeIcons.calendar,
                  text: item.createDate,
                ),*/
                SmallItem(
                  icon: LineAwesomeIcons.clock_o,
                  text: item.time.toString(),
                ),
                /*SmallItem(
                  icon: LineAwesomeIcons.dollar,
                  text: item.price.toString(),
                ),*/
              ],
            ),
          ),
          FromTo(
            from: "From",
            to: "To",
          )
          /*ListTile(
            leading: Icon(
              LineAwesomeIcons.map_marker,
              color: Colors.black,
            ),
            title: Text(item.noidi),
            subtitle: Text(item.noiden),
          )*/
        ],
      ),
    );
  }
}

class SmallItem extends StatelessWidget {
  final String text;
  final IconData icon;

  const SmallItem({Key key, this.text, this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Icon(icon),
        SizedBox(
          width: 4,
        ),
        Text(text)
      ],
    );
  }
}
