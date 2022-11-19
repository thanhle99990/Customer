import 'dart:async';

import 'package:provider_arc/core/models/response.dart';
import 'package:provider_arc/core/models/userobj.dart';
import 'package:provider_arc/core/services/api.dart';

class AuthenticationService {
  final Api _api;

  AuthenticationService({Api api}) : _api = api;

  StreamController<UserObj> _userController = StreamController<UserObj>();

  Stream<UserObj> get user => _userController.stream;

  Future<ResponseObj> login(String email, String password) async {
    ResponseObj responseObj = await _api.login(email, password);
    if (responseObj.code == 0) {
      UserObj fetchedUser = UserObj.fromJson(responseObj.data);
      print('name:' + fetchedUser.name);
      _userController.add(fetchedUser);
      print(responseObj.data);
    }
    return responseObj;
  }

  Future<ResponseObj> loginPhone(String phone) async {
    ResponseObj responseObj = await _api.loginPhone(phone);
    if (responseObj.code == 0) {
      UserObj fetchedUser = UserObj.fromJson(responseObj.data);
       print('verify otp:' + fetchedUser.verify);
      _userController.add(fetchedUser);
      print(responseObj.data);
    }
    return responseObj;
  }

  Future<ResponseObj> getUserDetail() async {
    ResponseObj responseObj = await _api.getUserDetail();
    if (responseObj.code == 0) {
      UserObj fetchedUser = UserObj.fromJson(responseObj.data);
      print('getuser:' + fetchedUser.phone);
      _userController.add(fetchedUser);
      print(responseObj.data);
    }
    return responseObj;
  }

  Future<ResponseObj> signup(UserObj userObj) async {
    ResponseObj responseObj = await _api.signup(userObj);
    if (responseObj.code == 0) {
      login(userObj.email, userObj.password);
    }
    return responseObj;
  }

  Future<String> uploadProfile(String base64) async {
    String filename = await _api.uploadProfile(base64);
    print(filename);
    return filename;
  }

  Future<ResponseObj> resetPassword(String email) async {
    ResponseObj responseObj = await _api.resetPassword(email);
    return responseObj;
  }

  void addUser(UserObj newUser) {
    _userController.add(newUser);
  }
}
