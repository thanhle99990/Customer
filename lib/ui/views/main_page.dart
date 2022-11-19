import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kf_drawer/kf_drawer.dart';
import 'package:provider/provider.dart';
import 'package:provider_arc/core/constants/app_contstants.dart';
import 'package:provider_arc/core/models/userobj.dart';
import 'package:provider_arc/core/services/api.dart';
import 'package:provider_arc/core/utils/pref_helper.dart';
import 'package:provider_arc/ui/shared/app_colors.dart';
import 'package:provider_arc/ui/shared/ui_helpers.dart';
import 'package:provider_arc/ui/views/chat/all_users_screen.dart';
import 'package:provider_arc/ui/views/home/home_view.dart';
import 'package:provider_arc/ui/views/other/notification_view.dart';
import 'package:provider_arc/ui/views/other/webview.dart';
import 'package:provider_arc/ui/views/other/webview2.dart';
import 'package:provider_arc/ui/views/payment/payment.dart';
import 'package:provider_arc/ui/views/place/favourite_view.dart';
import 'package:provider_arc/ui/views/ride/history.dart';
import 'package:provider_arc/ui/widgets/dummy.dart';
import 'package:provider_arc/ui/widgets/my/star.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainPage extends StatefulWidget {
  MainPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MainWidgetState createState() => _MainWidgetState();
}

class _MainWidgetState extends State<MainPage> with TickerProviderStateMixin {
  KFDrawerController _drawerController;

  //UserObj userObj;
  double rating;

  @override
  void initState() {
    getData();
    super.initState();
    _drawerController = KFDrawerController(
      initialPage: HomeView(),
      items: [
        KFDrawerItem.initWithPage(
          text: Text('HOME', style: TextStyle(color: Colors.white)),
          icon: Icon(Icons.home, color: Colors.white),
          page: HomeView(),
        ),
        KFDrawerItem.initWithPage(
          text: Text(
            'MY TRIP',
            style: TextStyle(color: Colors.white),
          ),
          icon: Icon(Icons.local_taxi, color: Colors.white),
          page: HistoryView(),
        ),
        KFDrawerItem.initWithPage(
          text: Text(
            'PAYMENT',
            style: TextStyle(color: Colors.white),
          ),
          icon: Icon(Icons.credit_card, color: Colors.white),
          page: PaymementView(),
        ),
        KFDrawerItem.initWithPage(
          text: Text(
            'MY PLACES',
            style: TextStyle(color: Colors.white),
          ),
          icon: Icon(Icons.map, color: Colors.white),
          page: FavoriteView(),
        ),
        KFDrawerItem.initWithPage(
          text: Text(
            'NOTIFICATION',
            style: TextStyle(color: Colors.white),
          ),
          icon: Icon(Icons.notifications_none_outlined, color: Colors.white),
          page: NotificationView(),
        ),
        /*KFDrawerItem.initWithPage(
          text: Text(
            'CHAT',
            style: TextStyle(color: Colors.white),
          ),
          icon: Icon(Icons.chat_outlined, color: Colors.white),
          page: AllUsersScreen(),
        ),*/
        /*KFDrawerItem.initWithPage(
          text: Text(
            'T & A',
            style: TextStyle(color: Colors.white),
          ),
          icon: Icon(Icons.insert_drive_file_outlined, color: Colors.white),
          page: WebViewPage('Terms and Agreement','/public/pages/agreement.html'),
        ),*/
        KFDrawerItem.initWithPage(
          text: Text(
            'PRIVACY & POLICY',
            style: TextStyle(color: Colors.white),
          ),
          icon: Icon(Icons.insert_drive_file_outlined, color: Colors.white),
          page: WebViewPage2('Privacy & Policy','/public/pages/privacy.html'),
        ),
        /*KFDrawerItem.initWithPage(
          text: Text(
            'ABOUT',
            style: TextStyle(color: Colors.white),
          ),
          icon: Icon(Icons.info_outline, color: Colors.white),
          page: AboutPage(),
        ),*/
      ],
    );
  }

  Future<void> getData() async {
    Api api = Api();
    rating = await api.getRating();
    //userObj = Provider.of<UserObj>(context);
    setState(() {
      rating;
      //userObj;
    });
  }

  @override
  Widget build(BuildContext context) {
    UserObj userObj = Provider.of<UserObj>(context);
    return Scaffold(
      body: KFDrawer(
        controller: _drawerController,
        header: Provider.of<UserObj>(context) == null
            ? Dummy()
            : SizedBox(
                height: 130,
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: GestureDetector(
                      onTap: () =>
                          {Navigator.pushNamed(context, RoutePaths.Profile)},
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              decoration: new BoxDecoration(
                                shape: BoxShape.circle,
                                border: new Border.all(
                                  color: Colors.white,
                                  width: 2.0,
                                ),
                              ),
                              child: CircleAvatar(
                                radius: 32,
                                backgroundImage: NetworkImage(
                                  userObj.profile,
                                ),
                              ),
                            ),
                            UIHelper.horizontalSpaceSmall,
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                UIHelper.verticalSpaceSmall,
                                Text(
                                  userObj.name,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18
                                  ),
                                ),
                                //UIHelper.verticalSpaceSmall,
                                Star(
                                  rating: userObj.rating,
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
        footer: KFDrawerItem(
          text: Text(
            'SIGN OUT',
            style: TextStyle(color: Colors.white),
          ),
          icon: Icon(
            Icons.input,
            color: Colors.white,
          ),
          onPressed: () async {
            SharedPreferenceHelper _sharedPreferenceHelper =
            SharedPreferenceHelper();
            _sharedPreferenceHelper.setLogin(false);
            _sharedPreferenceHelper.setUserId(null);
            Navigator.of(context).pushReplacementNamed(RoutePaths.Authen);
          },
        ),
        decoration: BoxDecoration(color: PrimaryColor),
      ),
    );
  }
}

// ignore: must_be_immutable
class AboutPage extends KFDrawerContent {
  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  child: Material(
                    shadowColor: Colors.transparent,
                    color: Colors.transparent,
                    child: IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.black,
                      ),
                      onPressed: widget.onMenuPressed,
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  UIHelper.verticalSpaceSmall,
                  Text("About")
                  /*ListTile(
                    title: Text('+84.939170707'),
                    leading: Icon(FontAwesomeIcons.whatsapp),
                  ),
                  ListTile(
                    title: Text('jeetebe@gmail.com'),
                    leading: Icon(Mdi.email),
                  ),
                  ListTile(
                    title: Text('https://apptot.vn'),
                    leading: Icon(Mdi.web),
                  ),*/
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
