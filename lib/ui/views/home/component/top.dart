import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_arc/core/constants/app_contstants.dart';
import 'package:provider_arc/core/viewmodels/views/notify_model.dart';
import 'package:provider_arc/ui/shared/app_colors.dart';

class HomeTop extends StatelessWidget {
  //final NotifyModel notifyModel;
  final GlobalKey<ScaffoldState> globalKey;

  const HomeTop({Key key, this.globalKey}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _notifyModel = Provider.of<NotifyModel>(context);
    return Padding(
      padding: const EdgeInsets.only(top: 24, left: 1),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(
            icon: new Icon(
              Icons.menu,
              color: PrimaryColor,
              size: 32,
            ),
            onPressed: () {
              globalKey.currentState.openDrawer();
            },
          ),
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: IconButton(
              icon: _notifyModel.notseen > 0
                  ? Badge(
                      badgeContent: Text(
                        '${_notifyModel.notseen}',
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                      child: IconButton(
                        onPressed: () {
                          Navigator.of(context)
                              .pushNamed(RoutePaths.Notication);
                        },
                        icon: Icon(
                          Icons.notifications,
                          color: PrimaryColor,
                          size: 28,
                        ),
                      ),
                    )
                  : IconButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed(RoutePaths.Notication);
                      },
                      icon: Icon(
                        Icons.notifications,
                        color: PrimaryColor,
                        size: 28,
                      ),
                    ),
              onPressed: () {
                _notifyModel.saveSeen();
              },
            ),
          ),
        ],
      ),
    );
  }
}
