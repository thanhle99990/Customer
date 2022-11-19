import 'package:flutter/material.dart';
import 'package:provider_arc/core/services/flutter_verificartion_code_input.dart';
import 'package:provider/provider.dart';
import 'package:provider_arc/core/constants/app_contstants.dart';
import 'package:provider_arc/core/models/userobj.dart';
import 'package:provider_arc/core/services/api.dart';
import 'package:provider_arc/core/utils/pref_helper.dart';
import 'package:provider_arc/core/viewmodels/views/login_view_model.dart';
import 'package:provider_arc/ui/shared/app_colors.dart';
import 'package:provider_arc/ui/shared/ui_helpers.dart';
import 'package:provider_arc/ui/widgets/custom/mytext.dart';
import 'package:provider_arc/ui/widgets/dummy.dart';
import 'package:provider_arc/ui/widgets/my/mybutton.dart';

import '../base_widget.dart';

class VerifyOTPView extends StatefulWidget {
  VerifyOTPView({Key key}) : super(key: key);

  @override
  _PhoneInputPageState createState() {
    return _PhoneInputPageState();
  }
}

class _PhoneInputPageState extends State<VerifyOTPView> {
  bool isvalid = true;
  String otp = '';
  //UserObj userObj ;
  Api api = Api();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> checkotp() async {
    if (Provider.of<UserObj>(context, listen: false).verify == otp) {
      setState(() {
        isvalid = true;
      });
      UserObj userObj = Provider.of<UserObj>(context, listen: false);
      SharedPreferenceHelper _sharedPrefsHelper = SharedPreferenceHelper();
      _sharedPrefsHelper.setLogin(true);
      _sharedPrefsHelper.setUserId(userObj.idcustomer);
      int num = await _sharedPrefsHelper.numAccess;
      num++;
      _sharedPrefsHelper.setNumAccess(num);

      Navigator.of(context).pushReplacementNamed(RoutePaths.Letgo);
    } else {
      setState(() {
        isvalid = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final UserObj userObj = Provider.of<UserObj>(context, listen: false);
    print(userObj);
    return BaseWidget<LoginViewModel>(
        model: LoginViewModel(authenticationService: Provider.of(context)),
        builder: (context, model, child) => Scaffold(
              body: Container(
                  color: Colors.white,
                  padding: EdgeInsets.all(20.0),
                  //color: Colors.grey.shade800,
                  child: ListView(children: <Widget>[
                    Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          MyH1(
                            text: "Verify phone number",
                          ),
                          Padding(
                              padding:
                                  const EdgeInsets.only(top: 26, bottom: 26),
                              child: Text(
                                  'Check your SMS messages.\nWe have sent you the PIN')),
                          UIHelper.verticalSpaceMedium,
                          Provider.of<UserObj>(context) == null
                              ? Dummy()
                              : Text(
                                  'PIN ${userObj.verify}',
                                  style: TextStyle(color: Colors.red),
                                ),
                          Center(
                            child: VerificationCodeInput(
                              keyboardType: TextInputType.number,
                              length: 4,
                              onCompleted: (String value) {
                                print(value);
                                setState(() {
                                  otp = value;
                                });
                                checkotp();
                              },
                            ),
                          ),
                          UIHelper.verticalSpaceSmall,
                          isvalid
                              ? SizedBox(
                                  height: 0,
                                )
                              : Center(
                                  child: Text(
                                  'Invalid OTP !',
                                  style: TextStyle(color: Colors.red),
                                  textAlign: TextAlign.center,
                                )),
                          UIHelper.verticalSpaceSmall,
                          Row(
                            children: <Widget>[
                              Text("Didn't receive SMS? ",
                                  style: TextStyle(color: Colors.grey)),
                              Text(
                                "Resend Code",
                                style: TextStyle(color: PrimaryColor),
                              )
                            ],
                          ),
                          UIHelper.verticalSpaceMedium,
                          MyButton(
                            caption: 'VERIFY',
                            fullsize: true,
                            onPressed: () => {checkotp()},
                          )
                        ])
                  ])),
            ));
  }
}
