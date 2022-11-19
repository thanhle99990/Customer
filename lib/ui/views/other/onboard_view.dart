import 'package:dot_pagination_swiper/dot_pagination_swiper.dart';
import 'package:flutter/material.dart';
import 'package:provider_arc/core/constants/app_contstants.dart';
import 'package:provider_arc/ui/shared/text_styles.dart';
import 'package:provider_arc/ui/shared/ui_helpers.dart';

class IntroView extends StatelessWidget {
  const IntroView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: DotPaginationSwiper(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/a1.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      UIHelper.verticalSpaceMedium,
                      UIHelper.verticalSpaceLarge,
                      Text(
                        "Request a Ride",
                        style: H1,
                      ),
                      UIHelper.verticalSpaceMedium,
                      Text(
                        "Request a ride get picked up by a \nnearby community driver",
                        style: H2,
                      ),
                    ],
                  ),
                )
              ],
            ),
            Stack(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/a2.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      UIHelper.verticalSpaceMedium,
                      UIHelper.verticalSpaceLarge,
                      Text(
                        "Vehicle Selection",
                        style: H1,
                      ),
                      UIHelper.verticalSpaceMedium,
                      Text(
                        "Users have the liberty to choose the \ntype of vehicle as per their need.",
                        style: H2,
                      ),
                    ],
                  ),
                )
              ],
            ),
            Stack(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/a3.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      UIHelper.verticalSpaceMedium,
                      UIHelper.verticalSpaceLarge,
                      Text(
                        "Live Ride Tracking",
                        style: H1,
                      ),
                      UIHelper.verticalSpaceMedium,
                      Text(
                        "Know your driver in advance be\nable to view current locatim in red\ntime on the map",
                        style: H2,
                      ),
                    ],
                  ),
                ),
                Spacer(),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    //color: Colors.white,
                    child: FlatButton(
                      onPressed: () =>
                          Navigator.popAndPushNamed(context, RoutePaths.Authen),
                      child: Text(
                        "START",
                        style: TextStyle(fontSize: 20.0),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
