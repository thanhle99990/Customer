import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_country_picker/flutter_country_picker.dart';
import 'package:image/image.dart' as ImageProcess;
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:provider_arc/core/models/response.dart';
import 'package:provider_arc/core/models/userobj.dart';
import 'package:provider_arc/core/services/authentication_service.dart';
import 'package:provider_arc/core/services/phone_auth.dart';
import 'package:provider_arc/core/utils/pref_helper.dart';
import 'package:provider_arc/core/viewmodels/views/login_view_model.dart';
import 'package:provider_arc/ui/shared/app_colors.dart';
import 'package:provider_arc/ui/shared/ui_helpers.dart';
import 'package:provider_arc/ui/views/base_widget.dart';
import 'package:provider_arc/ui/views/login/otpverify.dart';
import 'package:provider_arc/ui/widgets/custom/mydialog.dart';
import 'package:provider_arc/ui/widgets/custom/mytext.dart';
import 'package:provider_arc/ui/widgets/loading.dart';
import 'package:provider_arc/ui/widgets/my/mybutton.dart';
import 'package:provider_arc/ui/widgets/my/mytextfield.dart';

class SignupView extends StatefulWidget {
  SignupView({Key key}) : super(key: key);

  @override
  _LoginViewState createState() {
    return _LoginViewState();
  }
}

class _LoginViewState extends State<SignupView> {
  SharedPreferenceHelper sharedPrefsHelper = SharedPreferenceHelper();
  bool hidepass = true;
  Country _selected = Country.VN;
  final TextEditingController controllerMail = new TextEditingController();
  final TextEditingController controllerPassword = new TextEditingController();

  //final TextEditingController controllerPhone = new TextEditingController();
  final TextEditingController controllerName = new TextEditingController();
  File imageFile;
  List gender = ["Female", "Male", "Other"];
  String select;
  int sex;
  final scaffoldKey =
      GlobalKey<ScaffoldState>(debugLabel: "scaffold-get-phone");

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
            key: scaffoldKey,
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MyH1(
                          text: "Create account",
                        ),
                        imageFile == null
                            ? MaterialButton(
                                onPressed: () {
                                  DialogUtils.showPickImage(context,
                                      camBtnFunction: () {
                                    getImage(1);
                                  }, folderBtnFunction: () {
                                    getImage(2);
                                  });
                                },
                                color: LightColor,
                                child: Padding(
                                  padding: const EdgeInsets.all(24.0),
                                  child: Icon(
                                    Icons.camera_alt_outlined,
                                    color: PrimaryColor,
                                  ),
                                ),
                                shape: CircleBorder(),
                              )
                            : GestureDetector(
                                onTap: () {
                                  DialogUtils.showPickImage(context,
                                      camBtnFunction: () {
                                    getImage(1);
                                  }, folderBtnFunction: () {
                                    getImage(2);
                                  });
                                },
                                child: Container(
                                  decoration: new BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: new Border.all(
                                      color: PrimaryColor,
                                      width: 2.0,
                                    ),
                                  ),
                                  child: Container(
                                    decoration: new BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: new Border.all(
                                        color: Colors.white,
                                        width: 2.0,
                                      ),
                                    ),
                                    child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(80.0),
                                        child: SizedBox(
                                            height: 60,
                                            width: 60,
                                            child: Image.file(
                                              imageFile,
                                              fit: BoxFit.cover,
                                            ))),
                                  ),
                                ),
                              ),
                      ],
                    ),
                    UIHelper.verticalSpaceMedium,
                    MyTextField(
                      controllerText: controllerName,
                      name: "Full Name",
                      textInputType: TextInputType.emailAddress,
                    ),
                    UIHelper.verticalSpaceSmall,
                    MyTextField(
                      controllerText: controllerMail,
                      name: "Email",
                      textInputType: TextInputType.emailAddress,
                    ),
                    UIHelper.verticalSpaceSmall,
                    MyH2(text: "Password"),
                    UIHelper.verticalSpaceSmall,
                    TextField(
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
                    UIHelper.verticalSpaceSmall,
                    MyH2(text: "Phone number"),
                    UIHelper.verticalSpaceSmall,
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        CountryPicker(
                          showDialingCode: true,
                          showName: false,
                          onChanged: (Country country) {
                            setState(() {
                              _selected = country;
                            });
                          },
                          selectedCountry: _selected,
                        ),
                        Flexible(
                          child: TextField(
                            //controller: controllerPhone,
                            controller: Provider.of<PhoneAuthDataProvider>(
                                    context,
                                    listen: false)
                                .phoneNumberController,
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                                hintText: "Phone number",
                                hintStyle: TextStyle(color: Colors.black26),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.grey, width: 5.0),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12.0)),
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 16.0)),
                          ),
                        ),
                      ],
                    ),
                    UIHelper.verticalSpaceSmall,
                    //MyH2(text: "Gender"),
                    /*UIHelper.verticalSpaceSmall,
                    Row(
                      children: <Widget>[
                        addRadioButton(0, 'Female'),
                        addRadioButton(1, 'Male'),
                        //addRadioButton(2, 'Others'),
                      ],
                    ),*/
                    UIHelper.verticalSpaceMedium,
                    model.busy
                        ? Loading(small: true)
                        : MyButton(
                            caption: "Sign up",
                            fullsize: true,
                            onPressed: () {
                              signup(model);
                            },
                          ),
                    UIHelper.verticalSpaceSmall
                  ],
                ),
              ),
            )));
  }

  Row addRadioButton(int btnValue, String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Radio(
          activeColor: Theme.of(context).primaryColor,
          value: gender[btnValue],
          groupValue: select,
          onChanged: (value) {
            setState(() {
              print(value);
              select = value;
              sex = btnValue;
            });
          },
        ),
        Text(title)
      ],
    );
  }

  Future signup(LoginViewModel model) async {
    if (controllerName.text.isEmpty) {
      //DialogUtils.showToast("Please input your name");
      DialogUtils.showTopBoxError(context, "Please input your name");
      return;
    }
    if (controllerMail.text.isEmpty) {
      //DialogUtils.showToast("Please input email");
      DialogUtils.showTopBoxError(context, "Please input email");
      return;
    }
    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(controllerMail.text);
    if (!emailValid) {
      //DialogUtils.showToast("Email is invalid");
      DialogUtils.showTopBoxError(context, "Email is invalid");
      return;
    }
    if (controllerPassword.text.isEmpty) {
      //DialogUtils.showToast("Please input password");
      DialogUtils.showTopBoxError(context, "Please input password");
      return;
    }
    String phone = Provider.of<PhoneAuthDataProvider>(context, listen: false)
        .phoneNumberController
        .text;

    if (phone.isEmpty || phone.length < 5) {
      //DialogUtils.showToast("Please input phone");
      DialogUtils.showTopBoxError(context, "Please input phone");
      return;
    }
    /* if (sex == null) {
      DialogUtils.showToast("Please select gender");
      return;
    }*/
    if (imageFile == null) {
      //DialogUtils.showToast("Please upload image profile");
      DialogUtils.showTopBoxError(context, "Please upload image profile");
      return;
    }
    final _imageFile = ImageProcess.decodeImage(
      imageFile.readAsBytesSync(),
    );
    sharedPrefsHelper.setSignup(true);

    ResponseObj responseObj = await model.loginPhone(phone);
    if (responseObj.code == 0) {
      DialogUtils.showSimpleDialog(context,
          title: "Exits a account with this phone number " + phone);
    } else {
      String base64Image = 'data:image/png;base64,' +
          base64Encode(ImageProcess.encodePng(_imageFile));
      String profile = await model.uploadProfile(base64Image);
      UserObj newUser = UserObj();
      newUser.name = controllerName.text;
      newUser.email = controllerMail.text;
      newUser.password = controllerPassword.text;
      newUser.phone = phone;
      newUser.profile = profile;
      newUser.sex = sex;
      AuthenticationService _authenticationService =
          Provider.of<AuthenticationService>(context, listen: false);
      _authenticationService.addUser(newUser);
      startPhoneAuth();
    }
  }

  startPhoneAuth() async {
    final phoneAuthDataProvider =
        Provider.of<PhoneAuthDataProvider>(context, listen: false);
    phoneAuthDataProvider.loading = false;

    bool validPhone = await phoneAuthDataProvider.instantiate(
        dialCode: _selected.dialingCode,
        onCodeSent: () {
          Navigator.of(context).push(CupertinoPageRoute(
              builder: (BuildContext context) => PhoneAuthVerify()));
        },
        onFailed: () {
          _showSnackBar(phoneAuthDataProvider.message);
        },
        onError: () {
          _showSnackBar(phoneAuthDataProvider.message);
        });
    if (!validPhone) {
      phoneAuthDataProvider.loading = false;
      _showSnackBar("Oops! Number seems invaild");
      return;
    }
  }

  /// Get the image
  Future getImage(int chonloai) async {
    Navigator.pop(context);
    var image = await ImagePicker.pickImage(
        source: chonloai == 1 ? ImageSource.camera : ImageSource.gallery,
        maxWidth: 800.0,
        maxHeight: 800.0);

    if (image != null) {
      await _cropImage(image);
    }
  }

  /// Crop the image
  Future<Null> _cropImage(File image) async {
    File croppedImage = await ImageCropper.cropImage(
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
      ],
      sourcePath: image.path,
      maxWidth: 300,
      maxHeight: 300,
    );
    if (croppedImage != null) {
      imageFile = croppedImage;
      setState(() {});
    }
  }

  _showSnackBar(String text) {
    final snackBar = SnackBar(
      content: Text('$text'),
    );
    scaffoldKey.currentState.showSnackBar(snackBar);
  }
}
