import 'package:google_maps_flutter/google_maps_flutter.dart';
// https://viblo.asia/p/tai-sao-ban-nen-su-dung-constants-file-trong-swift-4P856qqGlY3
class RoutePaths {
  static const String Intro = 'intro';
  static const String Authen = 'authen';
  static const String Login = 'login';
  static const String ForgotPass = 'forgotpass';
  static const String Signup = 'signup';
  static const String MainPage = '/';
  static const String Splash = 'splash';
  static const String Post = 'post';
  static const String VerifyOtp = 'verifyotp';
  static const String Letgo = 'letgo';
  static const String Agreement = 'agreement';
  static const String Pickadresss = 'pickadresss';
  static const String Favourite = 'favourite';
  static const String Addplace = 'addplace';
  static const String AddplaceMap = 'addplacemap';
  static const String BookingStep = 'bookingstep';
  static const String Profile = 'profile';
  static const String Changepass = 'changepass';
  static const String Notication = 'notication';
  static const String Payment = 'payment';
  static const String SelectPayment = 'selectpayment';
  static const String AddPayment = 'addpayment';
  static const String Confirm = 'confirm';
  static const String Myorder = 'myorder';
  static const String Success = 'success';
  static const String OnRide = 'onride';
  static const String Test = 'test';
  static const String AddSender = 'addsender';
  static const String AddReceiver = 'addreceiver';
  static const String Allchatuser = 'allchatuser';
  static const String LoginGoogle = 'logingoogle';
  static const String Promo = 'promo';
}

class KEYS {

  static const endpoint = 'http://10.250.231.18:8000';
  static const socketIo = 'http://10.250.231.18:9000';

  static const String LOGIN = 'login';
  static const String SIGNUP = 'signup';
  static const String USER = 'user';
  static const String idcustomer = 'idcustomer';
  static const String NUMACCESS = 'numaccess';
  static const String KEYSEEN = 'keyseen';

  static const keyMap =
      'AIzaSyBsiGuMhvQPKgmI7MLd77wWH7MiHwyfLtY'; //REPLACE YOUR KEY
      //'AIzaSyC-uDYSJbafK6Ptn_JaehA5avxHSPxkcNI'; //REPLACE YOUR KEY
  static const keyDirectionMap =
      "AIzaSyBsiGuMhvQPKgmI7MLd77wWH7MiHwyfLtY"; //REPLACE YOUR KEY

}

class Constants {
  static const versioncode = 1;

  static const destinationMarkerId = "DestinationMarker";
  static const pickupMarkerId = "PickupMarker";
  static const currentLocationMarkerId = "currentLocationMarker";
  static const currentLocationIcon = "assets/icons/pick.png";
  static const currentRoutePolylineId = "currentRoutePolyline";
  static const driverRoutePolylineId = "driverRoutePolyline";
  static const driverMarkerId = "CurrentDriverMarker";
  static const driverOriginPolyId = "driverOriginPolyLine";

  //Polyline patterns
  List<List<PatternItem>> patterns = <List<PatternItem>>[
    <PatternItem>[], //line
    <PatternItem>[PatternItem.dash(30.0), PatternItem.gap(20.0)], //dash
    <PatternItem>[PatternItem.dot, PatternItem.gap(10.0)], //dot
    <PatternItem>[
      //dash-dot
      PatternItem.dash(30.0),
      PatternItem.gap(20.0),
      PatternItem.dot,
      PatternItem.gap(20.0)
    ],
  ];
}
