import 'package:flutter/material.dart';
import 'package:provider_arc/core/constants/app_contstants.dart';
import 'package:provider_arc/core/viewmodels/views/map_view_model.dart';
import 'package:provider_arc/ui/widgets/my/mybutton.dart';

class HomeBottom extends StatelessWidget {
  final MapViewModel mapModel;

  const HomeBottom({Key key, this.mapModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Spacer(),
        MaterialButton(
          onPressed: mapModel.onMyLocationFabClicked,
          color: Colors.white,
          textColor: Colors.white,
          child: Icon(
            Icons.my_location,
            size: 22,
            color: Colors.black,
          ),
          padding: EdgeInsets.all(8),
          shape: CircleBorder(),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: MyButton(
            caption: 'BOOK NOW',
            fullsize: true,
            onPressed: () => {
              //mapModel.add_order(),
              Navigator.of(context).pushNamed(RoutePaths.BookingStep)
            },
          ),
        )
      ],
    );
  }
}
