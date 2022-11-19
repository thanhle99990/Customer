import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider_arc/core/constants/app_contstants.dart';
import 'package:provider_arc/core/utils/device_utils.dart';
import 'package:provider_arc/ui/shared/ui_helpers.dart';
import 'package:provider_arc/ui/widgets/custom/mybuttonfull.dart';
import 'package:provider_arc/ui/widgets/custom/mytext.dart';

class LetgoView extends StatefulWidget {
  LetgoView({Key key}) : super(key: key);

  @override
  _LetgoViewState createState() => _LetgoViewState();
}

class _LetgoViewState extends State<LetgoView> {
  @override
  void initState() {
    super.initState();
    updateLocation();
  }

  void updateLocation() async {
    try {
      Position newPosition = await Geolocator.getCurrentPosition(
              desiredAccuracy: LocationAccuracy.best)
          .timeout(new Duration(seconds: 20));
      print(newPosition);
    } catch (e) {
      print('Error here ....: ${e.toString()}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            UIHelper.verticalSpaceLarge,
            MyH1(
              text: "You are ready to go",
            ),
            Text(
              'Thanks for taking your time to create\naccount with us. Now this is the fun part,\nlet\'s explore the app.',
              textAlign: TextAlign.center,
            ),
            //UIHelper.verticalSpaceLarge,
            Padding(
              padding: const EdgeInsets.all(32.0),
              child: Image.asset(
                'assets/images/enable.png',
                width: DeviceUtils.getScaledWidth(context, 1),
                //height: size.height,
                fit: BoxFit.fill,
              ),
            ),
            Text(
              "Enable location",
              style: TextStyle(color: Colors.grey, fontSize: 18),
            ),
            Spacer(),
            MyButtonFull(
              caption: "GET STARTED",
              onPressed: () => {
                Navigator.of(context).pushReplacementNamed(RoutePaths.MainPage)
              },
            )
          ],
        ),
      ),
    );
  }
}
