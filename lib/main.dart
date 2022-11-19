import 'dart:convert';

import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:provider_arc/core/models/version.dart';
import 'package:provider_arc/core/services/api.dart';
import 'package:provider_arc/core/services/authentication_service.dart';
import 'package:provider_arc/core/utils/pref_helper.dart';
import 'package:provider_arc/provider_setup.dart';
import 'package:provider_arc/ui/router.dart';
import 'package:provider_arc/ui/widgets/dummy.dart';
import 'package:url_launcher/url_launcher.dart';

import 'core/constants/app_contstants.dart';
import 'ui/shared/app_colors.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  //SystemChrome.setEnabledSystemUIOverlays([]);
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((_) {
    runApp(new MyApp());
  });
}

class MyApp extends StatelessWidget {
  static Map<int, Color> color = {
    50: Color.fromRGBO(252, 73, 69, .1),
    100: Color.fromRGBO(252, 73, 69, .2),
    200: Color.fromRGBO(252, 73, 69, .3),
    300: Color.fromRGBO(252, 73, 69, .4),
    400: Color.fromRGBO(252, 73, 69, .5),
    500: Color.fromRGBO(252, 73, 69, .6),
    600: Color.fromRGBO(252, 73, 69, .7),
    700: Color.fromRGBO(252, 73, 69, .8),
    800: Color.fromRGBO(252, 73, 69, .9),
    900: Color.fromRGBO(252, 73, 69, 1),
  };
  MaterialColor primeColor = MaterialColor(0xFFFF0000, color);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Customer',
        theme: ThemeData(
          primarySwatch: primeColor,
          primaryColor: PrimaryColor,
          //fontFamily: 'Avenir',
        ),
        initialRoute: RoutePaths.Splash,
        onGenerateRoute: Routers.generateRoute,
      ),
    );
  }
}

class SplashView extends StatefulWidget {
  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  SharedPreferenceHelper _sharedPreferenceHelper = SharedPreferenceHelper();
  Api api = Api();
  VersionObj versionObj;
  bool update = false;

  @override
  void initState() {
    super.initState();
    checkVersion();
  }

  Future<bool> checkIfAuthenticated() async {
    //return false;
    await Future.delayed(Duration(
        seconds:
            3)); // could be a long running task, like a fetch from keychain
    //SharedPreferences prefs = await SharedPreferences.getInstance();
    bool myBool = await _sharedPreferenceHelper.isLogin;
    print("login:" + myBool.toString());
    if (myBool == null) myBool = false;
    return myBool;
  }

  Future<void> checkVersion() async {
    //versionObj = await api.getVersion();
    //print(json.encode(versionObj));
    //update = versionObj.vscode > Constants.versioncode;
    // setState(() {
    //   versionObj;
    //   update;
    // });
    // print("update: $update");
    checkIfAuthenticated().then((success) {
      if (success) {
        Provider.of<AuthenticationService>(context, listen: false)
            .getUserDetail();
        Navigator.pushReplacementNamed(context, RoutePaths.MainPage);
      } else {
        Navigator.pushReplacementNamed(context, RoutePaths.Authen);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        color: Colors.white,
        child: Stack(
          children: [
            /*FlareActor(
              'assets/flare/intro.flr',
              alignment: Alignment.center,
              fit: BoxFit.fill,
              animation: 'play',
            ),

             */
            update
                ? Center(
                    child: FlatButton(
                        color: PrimaryColor,
                        onPressed: () {
                          _sharedPreferenceHelper.setLogin(false);
                          _sharedPreferenceHelper.setUserId(null);
                          _download();
                        },
                        child: Text(
                          'Download update',
                          style: TextStyle(color: Colors.white),
                        )),
                  )
                : Dummy(),
          ],
        ),
      ),
    );
  }

  Future<void> _download() async {
    String url = versionObj.apk;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
