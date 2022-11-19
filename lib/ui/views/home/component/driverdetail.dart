import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider_arc/core/models/driver.dart';
import 'package:provider_arc/ui/shared/app_colors.dart';
import 'package:provider_arc/ui/shared/text_styles.dart';
import 'package:provider_arc/ui/shared/ui_helpers.dart';

class DriverDetail extends StatelessWidget {
  final DriverObj driverObj;

  const DriverDetail({Key key, this.driverObj}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(16.0),
            child: Container(
              height: 60,
              width: 60,
              child: CachedNetworkImage(
                imageUrl: driverObj.profile,
                placeholder: (context, url) => new CircularProgressIndicator(),
                errorWidget: (context, url, error) => new Icon(Icons.error),
              ),
            ),
          ),
          UIHelper.horizontalSpaceSmall,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "${driverObj.name}",
                  style: TitleStyle,
                ),
                UIHelper.verticalSpaceSmall,
                ClipRRect(
                  borderRadius: BorderRadius.circular(16.0),
                  child: Container(
                      width: 70,
                      color: PrimaryColor,
                      child: Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "4.0",
                              style: TextStyle(color: Colors.white),
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            Icon(
                              Icons.star,
                              color: Colors.white,
                              size: 16,
                            )
                          ],
                        ),
                      )),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Text("Honda Civid"),
              Text("GT-125-TR-678",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: PrimaryColor)),
            ],
          )
        ],
      ),
    );
  }
}
