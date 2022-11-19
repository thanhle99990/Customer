import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider_arc/core/viewmodels/views/map_view_model.dart';
import 'package:provider_arc/ui/shared/app_colors.dart';
import 'package:provider_arc/ui/widgets/order/item1.dart';

class TripDetail extends StatelessWidget {
  final MapViewModel model;

  const TripDetail({Key key, this.model}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      color: LightBlue,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Item1(
            icon: FontAwesomeIcons.route,
            text: "${model.rideobj.kmtext}",
          ),
          Item1(
            icon: FontAwesomeIcons.clock,
            text: "${model.rideobj.time}",
          ),
          Item1(
            icon: FontAwesomeIcons.dollarSign,
            text: "Free",
          ),
          /* Item1(
            icon: FontAwesomeIcons.users,
            text: "${model.rideobj.pri} Seat",
          ),*/
        ],
      ),
    );
  }
}
