import 'package:flutter/material.dart';
import 'package:provider_arc/core/viewmodels/views/map_view_model.dart';
import 'package:provider_arc/ui/shared/app_colors.dart';

class MyLocation extends StatelessWidget {
  final MapViewModel model;

  const MyLocation({Key key, this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {//icon bấm vào để chỉnh map lại như cũ
    return Row(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
      ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(48.0)),
        child: Container(
          color: Colors.white,
          child: IconButton(
            icon: Icon(
              Icons.my_location,
              color: PrimaryColor,
              //size: 32,
            ),
            onPressed: model.onMyLocationFabClicked,
          ),
        ),
      ),
    ]);
  }
}
