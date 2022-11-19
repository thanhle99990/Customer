import 'package:flutter/widgets.dart';
import 'package:provider_arc/core/models/response.dart';
import 'package:provider_arc/core/models/userobj.dart';
import 'package:provider_arc/core/services/authentication_service.dart';
import 'package:provider_arc/core/viewmodels/base_model.dart';

class LoginViewModel extends BaseModel {
  AuthenticationService _authenticationService;

  LoginViewModel({
    @required AuthenticationService authenticationService,
  }) : _authenticationService = authenticationService;

  //
  Future<ResponseObj> login(String email, String password) async {
    setBusy(true);
    ResponseObj responseObj =
        await _authenticationService.login(email, password);
    setBusy(false);
    return responseObj;
  }

//
  Future<ResponseObj> loginPhone(String phone) async {
    setBusy(true);
    ResponseObj responseObj = await _authenticationService.loginPhone(phone);
    setBusy(false);
    return responseObj;
  }

  Future<ResponseObj> signup(UserObj userObj) async {
    userObj.idcustomer = null;
    setBusy(true);
    ResponseObj responseObj = await _authenticationService.signup(userObj);
    //await _authenticationService.login(userObj.email, userObj.password);
    setBusy(false);
    return responseObj;
  }

//
  Future<ResponseObj> getUserDetail(int userId) async {
    setBusy(true);
    ResponseObj responseObj = await _authenticationService.getUserDetail();
    setBusy(false);
    return responseObj;
  }

  Future<ResponseObj> resetPasword(String email) async {
    setBusy(true);
    ResponseObj responseObj = await _authenticationService.resetPassword(email);
    setBusy(false);
    return responseObj;
  }

  Future<String> uploadProfile(String base64Image) async {
    setBusy(true);
    String profile = await _authenticationService.uploadProfile(base64Image);
    setBusy(false);
    return profile;
  }

}
