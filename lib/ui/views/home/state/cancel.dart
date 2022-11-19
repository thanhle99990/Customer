import 'package:flutter/material.dart';
import 'package:provider_arc/core/viewmodels/views/map_view_model.dart';
import 'package:provider_arc/ui/shared/text_styles.dart';
import 'package:provider_arc/ui/shared/ui_helpers.dart';
import 'package:provider_arc/ui/widgets/custom/mytext.dart';
import 'package:provider_arc/ui/widgets/my/mybutton.dart';

class Cancel extends StatelessWidget {
  final MapViewModel model;

  const Cancel({Key key, this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white70,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(16),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Column(
                children: <Widget>[
                  UIHelper.verticalSpaceMedium,
                  Icon(
                    Icons.warning,
                    color: Colors.orange,
                    size: 60,
                  ),
                  MyH2(text: "CANCEL RIDE ?"),
                  UIHelper.verticalSpaceMedium,
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: MyButton(
                      caption: "Cancel",
                      fullsize: true,
                      onPressed: () {
                        model.cancelRide(); // send Message to socketio and send FCM to driver và trở về state none
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(16),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: FlatButton(
                onPressed: () {
                  model.cancelNo();
                },
                child: Text(
                  "Don't cancel ride",
                  style: H2,
                ),
              ),
            ),
          ),
          UIHelper.verticalSpaceSmall
        ],
      ),
    );
  }
}
