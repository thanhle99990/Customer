import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_arc/core/constants/app_contstants.dart';
import 'package:provider_arc/core/models/response.dart';
import 'package:provider_arc/core/models/userobj.dart';
import 'package:provider_arc/core/utils/pref_helper.dart';
import 'package:provider_arc/core/viewmodels/views/login_view_model.dart';
import 'package:provider_arc/ui/shared/app_colors.dart';
import 'package:provider_arc/ui/shared/delayed_animation.dart';
import 'package:provider_arc/ui/shared/ui_helpers.dart';
import 'package:provider_arc/ui/views/base_widget.dart';
import 'package:provider_arc/ui/widgets/custom/mydialog.dart';
import 'package:provider_arc/ui/widgets/custom/mytext.dart';
import 'package:provider_arc/ui/widgets/loading.dart';
import 'package:provider_arc/ui/widgets/my/mybutton.dart';
import 'package:provider_arc/ui/widgets/my/mytextfield.dart';

class LoginView extends StatefulWidget {
  LoginView({Key key}) : super(key: key);

  @override
  _LoginViewState createState() {
    return _LoginViewState();
  }
}

class _LoginViewState extends State<LoginView>
    with SingleTickerProviderStateMixin {
  bool hidepass = true;
  SharedPreferenceHelper sharedPrefsHelper = SharedPreferenceHelper();
  final TextEditingController controllerMail = new TextEditingController();
  final TextEditingController controllerPassword = new TextEditingController();

  AnimationController _controller;
  final int delayedAmount = 300;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 200,
      ),
      lowerBound: 0.0,
      upperBound: 0.1,
    )..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseWidget<LoginViewModel>(
        model: LoginViewModel(authenticationService: Provider.of(context)),
        builder: (context, model, child) => Scaffold(
            backgroundColor: Colors.white,
            appBar: new AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              leading: new IconButton(
                icon: new Icon(
                  Icons.arrow_back,
                  color: Dark,
                ),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
            body: SingleChildScrollView(
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    DelayedAnimation(
                      delay: delayedAmount * 1,
                      child: MyH1(
                        text: "Welcome back, Guy!",
                      ),
                    ),
                    UIHelper.verticalSpaceMedium,
                    DelayedAnimation(
                      delay: delayedAmount * 2,
                      child: MyTextField(
                        controllerText: controllerMail,
                        name: "Email",
                        textInputType: TextInputType.emailAddress,
                      ),
                    ),
                    UIHelper.verticalSpaceSmall,
                    DelayedAnimation(
                        delay: delayedAmount * 3,
                        child: MyH2(text: "Password")),
                    UIHelper.verticalSpaceSmall,
                    DelayedAnimation(
                      delay: delayedAmount * 3,
                      child: TextField(
                        controller: controllerPassword,
                        obscureText: hidepass,
                        decoration: InputDecoration(
                            hintText: "Enter your password",
                            hintStyle: TextStyle(color: Colors.black26),
                            suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  hidepass = !hidepass;
                                });
                              },
                              child: Icon(
                                Icons.remove_red_eye,
                                color: Colors.black26,
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: LightGrey, width: 5.0),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12.0)),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 16.0)),
                      ),
                    ),
                    UIHelper.verticalSpaceMedium,
                    DelayedAnimation(
                      delay: delayedAmount * 4,
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, RoutePaths.ForgotPass);
                          },
                          child: MyH3(
                            text: "Forgot your password?",
                          ),
                        ),
                      ),
                    ),
                    UIHelper.verticalSpaceMedium,
                    model.busy
                        ? Loading()
                        : DelayedAnimation(
                            delay: delayedAmount * 5,
                            child: MyButton(
                              caption: "Sign in",
                              fullsize: true,
                              onPressed: () {
                                login(model);
                              },
                            ),
                          ),
                    UIHelper.verticalSpaceSmall,
                  ],
                ),
              ),
            )));
  }

  Future login(LoginViewModel model) async {
    if (controllerMail.text.isEmpty) {
      //DialogUtils.showToast("Please input email");
      DialogUtils.showTopBoxError(context, "Please input email");
      return;
    }
    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(controllerMail.text);
    if (!emailValid) {
      DialogUtils.showTopBoxError(context, "Email is invalid");
      return;
    }
    if (controllerPassword.text.isEmpty) {
      DialogUtils.showTopBoxError(context, "Please input password");
      return;
    }
    sharedPrefsHelper.setSignup(false);
    ResponseObj responseObj =
        await model.login(controllerMail.text, controllerPassword.text);
    var loginSuccess = responseObj.code == 0;
    if (loginSuccess) {
      UserObj userObj = UserObj.fromJson(responseObj.data);
      sharedPrefsHelper.setLogin(true);
      sharedPrefsHelper.setUserId(userObj.idcustomer);
      Navigator.pushNamed(context, RoutePaths.MainPage);
    } else {
      DialogUtils.showSimpleDialog(
        context,
        title: responseObj.message,
      );
    }
  }
}
