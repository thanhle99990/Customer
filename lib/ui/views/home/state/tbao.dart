import 'package:flutter/material.dart';
import 'package:provider_arc/core/utils/device_utils.dart';
import 'package:provider_arc/core/viewmodels/views/map_view_model.dart';
import 'package:provider_arc/ui/shared/ui_helpers.dart';
import 'package:provider_arc/ui/widgets/custom/mybuttonfull.dart';

class Tbao extends StatelessWidget {
  final MapViewModel model;

  const Tbao({Key key, this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          height: DeviceUtils.getScaledHeight(context, 1),
          width: DeviceUtils.getScaledWidth(context, 1),
          color: Colors.black38,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(32.0),
              child: Container(
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    UIHelper.verticalSpaceMedium,
                    Text("${model.tbaoObj.noidung}"),
                    UIHelper.verticalSpaceMedium,
                    MyButtonFull(
                      caption: "Close",
                      onPressed: () {
                        model.hideNote();
                      },
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
