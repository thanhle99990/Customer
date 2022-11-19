import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:provider/provider.dart';
import 'package:provider_arc/core/constants/app_contstants.dart';
import 'package:provider_arc/core/models/userobj.dart';
import 'package:provider_arc/core/utils/device_utils.dart';
import 'package:provider_arc/core/utils/pref_helper.dart';
import 'package:provider_arc/ui/shared/app_colors.dart';
import 'package:provider_arc/ui/shared/text_styles.dart';
import 'package:provider_arc/ui/widgets/dummy.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({Key key}) : super(key: key);

  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    final _userObj = Provider.of<UserObj>(context);
    return _userObj == null
        ? Dummy()
        : Container(
            color: LightColor,
            child: Drawer(
              child: ListView(
                // Important: Remove any padding from the ListView.
                padding: EdgeInsets.zero,
                children: <Widget>[
                  Container(
                    height: DeviceUtils.getScaledHeight(context, 1) / 3,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.of(context).pushNamed(RoutePaths.MainPage);
                      },
                      child: Container(
                        child: DrawerHeader(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Align(
                                alignment: Alignment.centerRight,
                                child: IconButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    Navigator.of(context).pushNamed(
                                      RoutePaths.Profile,
                                      //arguments: {'userobj': _userObj}
                                    );
                                  },
                                  icon: Icon(
                                    LineAwesomeIcons.chevron_circle_right,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 16),
                                child: Material(
                                  elevation: 1.0,
                                  shape: CircleBorder(),
                                  child: CircleAvatar(
                                    radius: 30.0,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(80.0),
                                      child: _userObj == null
                                          ? Dummy()
                                          : CachedNetworkImage(
                                              imageUrl: "${_userObj.profile}",
                                              placeholder: (context, url) =>
                                                  new CircularProgressIndicator(),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      new Icon(Icons.error),
                                            ),
                                    ),
                                  ),
                                ),
                              ),
                              _userObj == null
                                  ? Dummy()
                                  : ListTile(
                                      title: Text(
                                        "${_userObj.name}",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      subtitle: Text(
                                        "Active: ${_userObj.lastactive.replaceAll('.000Z', '')}",
                                        style: TextStyle(color: Colors.white70),
                                      ),
                                    ),
                            ],
                          ),
                          decoration: BoxDecoration(
                            color: PrimaryColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                  ListTile(
                    leading: Icon(LineAwesomeIcons.history),
                    title: Text(
                      'My rides',
                      style: normalStyle,
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.of(context).pushNamed(RoutePaths.Myorder);
                    },
                  ),
                  ListTile(
                    leading: Icon(LineAwesomeIcons.map_marker),
                    title: Text(
                      'My Place',
                      style: normalStyle,
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.of(context).pushNamed(RoutePaths.Favourite);
                    },
                  ),
                  ListTile(
                    leading: Icon(LineAwesomeIcons.credit_card),
                    title: Text(
                      'Payment',
                      style: normalStyle,
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.of(context).pushNamed(RoutePaths.Payment);
                    },
                  ),
                  ListTile(
                    leading: Icon(
                      LineAwesomeIcons.bell_o,
                    ),
                    title: Text(
                      'Notifications',
                      style: normalStyle,
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.of(context).pushNamed(RoutePaths.Notication);
                    },
                  ),
                  ListTile(
                    leading: Icon(
                      LineAwesomeIcons.wechat,
                    ),
                    title: Text(
                      'Chat',
                      style: normalStyle,
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  /*ListTile(
              leading: Icon(LineAwesomeIcons.headphones),
              title: Text(
                'Support',
                style: normalStyle,
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).pushNamed(RoutePaths.OnRide);
              },
            ),*/
                  ListTile(
                    leading: Icon(LineAwesomeIcons.file_text),
                    title: Text(
                      'Terms & Agreement',
                      style: normalStyle,
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.of(context).pushNamed(RoutePaths.Agreement);
                    },
                  ),
                  //Spacer(),
                  ListTile(
                    leading: Icon(LineAwesomeIcons.sign_out),
                    title: Text(
                      'Logout',
                      style: normalStyle,
                    ),
                    onTap: () async {
                      SharedPreferenceHelper _sharedPreferenceHelper =
                      SharedPreferenceHelper();
                      _sharedPreferenceHelper.setLogin(false);
                      _sharedPreferenceHelper.setUserId(null);
                      Navigator.of(context)
                          .pushReplacementNamed(RoutePaths.Authen);
                    },
                  ),
                ],
              ),
            ),
          );
  }
}
