import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as ImageProcess;
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:provider/provider.dart';
import 'package:provider_arc/core/constants/app_contstants.dart';
import 'package:provider_arc/core/models/userobj.dart';
import 'package:provider_arc/core/services/api.dart';
import 'package:provider_arc/core/services/authentication_service.dart';
import 'package:provider_arc/ui/shared/app_colors.dart';
import 'package:provider_arc/ui/shared/ui_helpers.dart';
import 'package:provider_arc/ui/widgets/custom/mydialog.dart';
import 'package:provider_arc/ui/widgets/custom/mytext.dart';
import 'package:provider_arc/ui/widgets/my/mybutton.dart';

import '../../widgets/mybuttono.dart';

class ProfileView extends StatefulWidget {
  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  //UserObj userObj;
  Api _api = Api();
  final TextEditingController controllerMail = TextEditingController();
  final TextEditingController controllerAddress = new TextEditingController();
  final TextEditingController controllerName = new TextEditingController();
  final TextEditingController controllerPhone = new TextEditingController();
  bool isEdited = false;
  bool isProfile = false;
  File imageFile;
  final List<MenuItem> categories = [
    MenuItem(0, "Thư viện", icon: LineAwesomeIcons.folder_open),
    MenuItem(1, "Camera", icon: LineAwesomeIcons.camera),
  ];

  List gender = ["Female", "Male", "Other"];
  String select;
  int sex;
  UserObj userObj;

  @override
  void initState() {
    userObj = Provider.of<UserObj>(context, listen: false);
    super.initState();
    controllerName.text = userObj.name;
    controllerMail.text = userObj.email;
    controllerPhone.text = userObj.phone;
    controllerAddress.text = userObj.address;
    //select = gender[userObj.sex];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: new IconButton(
          icon: new Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: <Widget>[
          FlatButton(
            child: isEdited
                ? Text('Editing', style: TextStyle(color: PrimaryColor))
                : Text('Edit'),
            onPressed: () {
              setState(() {
                isEdited = !isEdited;
              });
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              MyH1(
                text: isEdited ? "Edit Profile" : "Profile",
              ),
              UIHelper.verticalSpaceMedium,
              Align(
                  alignment: Alignment.center,
                  child: isProfile
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(80.0),
                          child: SizedBox(
                              height: 80,
                              width: 80,
                              child: Image.file(
                                imageFile,
                                fit: BoxFit.cover,
                              )))
                      : isEdited
                          ? Material(
                              elevation: 1.0,
                              shape: CircleBorder(),
                              child: CircleAvatar(
                                  radius: 40.0,
                                  backgroundColor: PrimaryColor,
                                  child: IconButton(
                                    onPressed: () => selectImage(context),
                                    icon: Icon(
                                      LineAwesomeIcons.camera,
                                      size: 32,
                                      color: Colors.white,
                                    ),
                                  )))
                          : Container(
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
                                    width: 3.0,
                                  ),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(80.0),
                                  child: SizedBox(
                                    height: 80,
                                    width: 80,
                                    child: CachedNetworkImage(
                                      imageUrl: '${userObj.profile}',
                                      placeholder: (context, url) =>
                                          new CircularProgressIndicator(),
                                      errorWidget: (context, url, error) =>
                                          new Icon(Icons.error),
                                    ),
                                  ),
                                ),
                              ),
                            )),
              UIHelper.verticalSpaceMedium,
              Text("User name", style: TextStyle(color: Colors.grey)),
              UIHelper.verticalSpaceSmall,
              TextField(
                enabled: isEdited,
                controller: controllerName,
                decoration: InputDecoration(
                    hintText: "User name",
                    hintStyle: TextStyle(color: Colors.black26),
                    border: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.blueGrey, width: 5.0),
                      borderRadius: BorderRadius.all(Radius.circular(16.0)),
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0)),
              ),
              UIHelper.verticalSpaceSmall,
              Text("Email", style: TextStyle(color: Colors.grey)),
              UIHelper.verticalSpaceSmall,
              TextField(
                enabled: false,
                controller: controllerMail,
                decoration: InputDecoration(
                    hintText: "Email",
                    hintStyle: TextStyle(color: Colors.black26),
                    border: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.blueGrey, width: 5.0),
                      borderRadius: BorderRadius.all(Radius.circular(16.0)),
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0)),
              ),
              UIHelper.verticalSpaceSmall,
              Text("Phone", style: TextStyle(color: Colors.grey)),
              UIHelper.verticalSpaceSmall,
              TextField(
                enabled: false,
                controller: controllerPhone,
                decoration: InputDecoration(
                    hintText: "Phone",
                    hintStyle: TextStyle(color: Colors.black26),
                    border: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.blueGrey, width: 5.0),
                      borderRadius: BorderRadius.all(Radius.circular(16.0)),
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0)),
              ),
              UIHelper.verticalSpaceSmall,
              /*Text("Gender", style: TextStyle(color: Colors.grey)),
              UIHelper.verticalSpaceSmall,
              Row(
                children: <Widget>[
                  addRadioButton(0, 'Female'),
                  addRadioButton(1, 'Male'),
                  //addRadioButton(2, 'Others'),
                ],
              ),*/
              UIHelper.verticalSpaceSmall,
              isEdited
                  ? MyButton(
                      caption: 'Update',
                      fullsize: true,
                      onPressed: () {
                        update();
                      },
                    )
                  : MyButtonO(
                      caption: 'Change password',
                      fullsize: true,
                      onPressed: () {
                        Navigator.of(context).pushNamed(RoutePaths.Changepass);
                      },
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Future getImage(int chonloai) async {
    // ignore: deprecated_member_use
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
      isProfile = true;
      setState(() {});
    }
  }

  Widget _buildCategoryItem(BuildContext context, int index, Color mau) {
    MenuItem category = categories[index];
    return MaterialButton(
      elevation: 0.0,
      highlightElevation: 1.0,
      onPressed: () => categoryPressed(context, category),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
      textColor: mau,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          if (category.icon != null) Icon(category.icon),
          if (category.icon != null) SizedBox(height: 5.0),
          Text(
            category.name,
            textAlign: TextAlign.center,
            maxLines: 3,
          ),
        ],
      ),
    );
  }

  void categoryPressed(BuildContext context, MenuItem menuItem) async {
    print(menuItem.id);
    Navigator.pop(context);
    if (menuItem.id == 0) {
      print('folder');
      getImage(0);
    }
    if (menuItem.id == 1) {
      print('camera');
      getImage(1);
    }
  }

  void selectImage(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            child: new Wrap(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      _buildCategoryItem(context, 0, PrimaryColor),
                      _buildCategoryItem(context, 1, PrimaryColor),
                    ],
                  ),
                )
              ],
            ),
          );
        });
  }

  void update() async {
    if (controllerName.text.isEmpty) {
      DialogUtils.showToast("Please input name");
      return;
    }
    if (imageFile != null) {
      final _imageFile = ImageProcess.decodeImage(
        imageFile.readAsBytesSync(),
      );
      String base64Image = 'data:image/png;base64,' +
          base64Encode(ImageProcess.encodePng(_imageFile));
      await _api.uploadProfile(base64Image);
    }
    UserObj newUser = UserObj();
    newUser.name = controllerName.text;
    newUser.address = controllerMail.text;
    newUser.sex = sex;
    await _api.updateProfile(newUser);
    AuthenticationService _authenticationService = Provider.of(context);
    await _authenticationService.getUserDetail();
    setState(() {
      isEdited = false;
    });
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
}

class MenuItem {
  final int id;
  final String name;
  final dynamic icon;

  MenuItem(this.id, this.name, {this.icon});
}
