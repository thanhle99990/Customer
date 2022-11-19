import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_arc/core/models/response.dart';
import 'package:provider_arc/core/viewmodels/views/login_view_model.dart';
import 'package:provider_arc/ui/shared/app_colors.dart';
import 'package:provider_arc/ui/shared/ui_helpers.dart';
import 'package:provider_arc/ui/views/base_widget.dart';
import 'package:provider_arc/ui/widgets/custom/mydialog.dart';
import 'package:provider_arc/ui/widgets/custom/mytext.dart';
import 'package:provider_arc/ui/widgets/my/mybutton.dart';
import 'package:provider_arc/ui/widgets/my/mytextfield.dart';

class ForgotPassView extends StatefulWidget {
  ForgotPassView({Key key}) : super(key: key);

  @override
  _ForgotPassViewState createState() {
    return _ForgotPassViewState();
  }
}

class _ForgotPassViewState extends State<ForgotPassView> {
  final TextEditingController controllerMail = new TextEditingController();

  @override
  void initState() {
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
              body: Container(
                padding: EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    MyH1(
                      text: "Forgot Password",
                    ),
                    UIHelper.verticalSpaceMedium,
                    Text(
                        "Enter your email below and we will \n send you an email"),
                    UIHelper.verticalSpaceMedium,
                    MyTextField(
                      controllerText: controllerMail,
                      name: "Email",
                      textInputType: TextInputType.emailAddress,
                    ),
                    UIHelper.verticalSpaceMedium,
                    MyButton(
                      caption: "Send",
                      fullsize: true,
                      onPressed: () {
                        forgotPass(model);
                      },
                    ),
                  ],
                ),
              ),
            ));
  }

  Future<void> forgotPass(LoginViewModel model) async {
    ResponseObj responseObj = await model.resetPasword(controllerMail.text);
    if (responseObj.code == 0) {
      DialogUtils.showSimpleDialog(context, title: "Please check your email");
    } else {
      DialogUtils.showSimpleDialog(context, title: responseObj.message);
    }
  }
}
