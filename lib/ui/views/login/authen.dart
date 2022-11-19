import 'package:flutter/material.dart';
import 'package:location/location.dart' as location;
import 'package:provider_arc/core/constants/app_contstants.dart';
import 'package:provider_arc/ui/shared/text_styles.dart';
import 'package:provider_arc/ui/shared/ui_helpers.dart';
import 'package:provider_arc/ui/widgets/my/avatar.dart';
import 'package:provider_arc/ui/widgets/my/mybutton.dart';
import 'package:provider_arc/ui/widgets/mybuttono.dart';

class AuthenView extends StatefulWidget {
  AuthenView({Key key}) : super(key: key);

  @override
  _AuthenViewState createState() {
    return _AuthenViewState();
  }
}

class _AuthenViewState extends State<AuthenView> {
  location.Location _location = location.Location();

  @override
  void initState() {
    super.initState();
    getLocation();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void getLocation() {
    _location.getLocation().then((data) async {
      print(data);
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Center(
            child: new Image.asset(
              'assets/images/bg.png',
              width: size.width,
              height: size.height,
              fit: BoxFit.fill,
            ),
          ),
          Column(
            children: <Widget>[
              UIHelper.verticalSpaceLarge,
             /* SizedBox(
                child: MyAvatarR(
                  url: 'assets/icons/icon.png',
                  size: size.width/8,
                ),
              ),*/
              Image.asset("assets/icons/icon.png"),
              Text(
                "",
                style: H1,
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.all(24),
                //color: Colors.green,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    MyButton(
                        caption: "Sign up",
                        fullsize: false,
                        onPressed: () =>
                            Navigator.pushNamed(context, RoutePaths.Signup)),
                    MyButtonO(
                        caption: "Login",
                        fullsize: false,
                        onPressed: () =>
                            Navigator.pushNamed(context, RoutePaths.Login))
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
