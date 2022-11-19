import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider_arc/core/constants/app_contstants.dart';
import 'package:provider_arc/core/models/response.dart';
import 'package:provider_arc/core/services/api.dart';
import 'package:provider_arc/ui/shared/text_styles.dart';
import 'package:provider_arc/ui/shared/ui_helpers.dart';
import 'package:provider_arc/ui/widgets/custom/mydialog.dart';
import 'package:provider_arc/ui/widgets/loading.dart';
import 'package:provider_arc/ui/widgets/my/mybutton.dart';
import 'package:provider_arc/ui/widgets/my/mytextfield.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChangepassView extends StatefulWidget {
  @override
  _ChangepassViewState createState() => _ChangepassViewState();
}

class _ChangepassViewState extends State<ChangepassView> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool hidepass = true;
  final TextEditingController controllerPass1 = TextEditingController();
  final TextEditingController controllerPass2 = new TextEditingController();
  Api _api = Api();
  bool loading = false;

  _done() async {
    if (controllerPass2.text.isEmpty) {
      DialogUtils.showToast("Please input password");
      return;
    }
    if (controllerPass1.text.isEmpty) {
      DialogUtils.showToast("Please input password");
      return;
    }
    setState(() {
      loading = true;
    });
    if (controllerPass2.text.toString() == controllerPass1.text.toString()) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      int userId = prefs.getInt(KEYS.idcustomer);
      ResponseObj responseObj =
          await _api.changePassword(userId, controllerPass2.text);
      String msg = '';
      if (responseObj.code == 0) {
        msg = 'Change password successful';
      } else {
        msg = 'Error';
      }
      DialogUtils.showToastSuccess(msg);
      //Navigator.pop(context);
    } else {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text('Two password input mismatch'),
        duration: Duration(seconds: 3),
      ));
    }
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: new AppBar(
          title: new Text(
            'Change password',
            style: TitleStyle,
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          leading: new IconButton(
            icon: new Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: Builder(
          builder: (context) => Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                MyTextField(
                  name: "New password",
                  controllerText: controllerPass2,
                ),
                UIHelper.verticalSpaceSmall,
                MyTextField(
                  name: "Retype password",
                  controllerText: controllerPass1,
                ),
                UIHelper.verticalSpaceMedium,
                loading
                    ? Loading(
                        small: true,
                      )
                    : MyButton(
                        caption: 'DONE',
                        fullsize: true,
                        onPressed: () {
                          _done();
                        },
                      )
              ],
            ),
          ),
        ));
  }
}
