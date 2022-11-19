import 'dart:convert';

import 'package:enum_to_string/enum_to_string.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:provider_arc/core/constants/app_contstants.dart';
import 'package:provider_arc/core/constants/enum.dart';
import 'package:provider_arc/core/models/car.dart';
import 'package:provider_arc/core/models/card.dart';
import 'package:provider_arc/core/models/distnattime.dart';
import 'package:provider_arc/core/models/driver.dart';
import 'package:provider_arc/core/models/geoobj.dart';
import 'package:provider_arc/core/models/his.dart';
import 'package:provider_arc/core/models/logtripobj.dart';
import 'package:provider_arc/core/models/notification.dart';
import 'package:provider_arc/core/models/placeitemres.dart';
import 'package:provider_arc/core/models/placeobj.dart';
import 'package:provider_arc/core/models/rating.dart';
import 'package:provider_arc/core/models/request.dart';
import 'package:provider_arc/core/models/response.dart';
import 'package:provider_arc/core/models/ride.dart';
import 'package:provider_arc/core/models/setting.dart';
import 'package:provider_arc/core/models/userobj.dart';
import 'package:provider_arc/core/models/vehicle.dart';
import 'package:provider_arc/core/models/version.dart';
import 'package:provider_arc/core/utils/device_utils.dart';
import 'package:provider_arc/core/utils/log.dart';
import 'package:provider_arc/core/utils/pref_helper.dart';

class Api {
  var client = new http.Client();
  SharedPreferenceHelper sharedPreferenceHelper = SharedPreferenceHelper();

  Future<VersionObj> getVersion() async {
    var _url = await sharedPreferenceHelper.endpoint + "/api/app/cversion";
    final response = await makeRequest(_url);
    VersionObj versionObj;
    if (response.statusCode == 200) {
      final Map parsed = json.decode(response.body);
      ResponseObj responseObj = ResponseObj.fromJson(parsed);
      versionObj = VersionObj.fromJson(responseObj.data);
    } else {
      throw Exception('Failed to load data');
    }
    return versionObj;
  }

  Future<SettingObj> getSetting() async {
    var _url = await sharedPreferenceHelper.endpoint + "/api/setting";
    final response = await makeRequest(_url);
    SettingObj settingObj;
    if (response.statusCode == 200) {
      final Map parsed = json.decode(response.body);
      ResponseObj responseObj = ResponseObj.fromJson(parsed);
      settingObj = SettingObj.fromJson(responseObj.data);
    } else {
      throw Exception('Failed to load data');
    }
    return settingObj;
  }

  //=========================================================================================== <USER>
  static const String USER = "";

  Future<ResponseObj> login(String email, String password) async {
    Map data = {'email': email, 'password': password};
    var body = json.encode(data);
    var _url =
        await sharedPreferenceHelper.endpoint + "/api/customer/loginemail";
    http.Response response = await makePost(_url, body);
    return ResponseObj.fromJson(json.decode(response.body));
  }

  Future<ResponseObj> loginPhone(String phone) async {
    Map data = {'phone': phone};
    var body = json.encode(data);
    var _url =
        await sharedPreferenceHelper.endpoint + "/api/customer/loginphone";
    http.Response response = await makePost(_url, body);
    return ResponseObj.fromJson(json.decode(response.body));
  }

  Future<ResponseObj> getUserDetail() async {
    int userId = await Utils.getUserId();//lấy userid(idcustomer đc lưu trong prefs, có thể duy trì đăng nhập
    var _url = await sharedPreferenceHelper.endpoint + "/api/customer/detail/$userId";
    final response = await makeRequest(_url);
    print('nhan dc: ${response.body}');
    return ResponseObj.fromJson(json.decode(response.body));//trả về UserDetail
  }

  Future<ResponseObj> signup(UserObj userObj) async {
    var body = json.encode(userObj);
    var _url = await sharedPreferenceHelper.endpoint + "/api/customer/signup";
    http.Response response = await makePost(_url, body);
    return ResponseObj.fromJson(json.decode(response.body));
  }

  Future<ResponseObj> changePassword(int userId, String password) async {
    Map data = {
      'idcustomer': userId,
      'password': password,
    };
    var body = json.encode(data);
    var _url = await sharedPreferenceHelper.endpoint + "/api/customer";
    http.Response response = await makePut(_url, body);
    return ResponseObj.fromJson(json.decode(response.body));
  }

  Future<ResponseObj> resetPassword(String email) async {
    Map data = {
      'email': email,
    };
    var body = json.encode(data);
    var _url = KEYS.endpoint + "/api/customer/resetpass";
    http.Response response = await makePost(_url, body);
    return ResponseObj.fromJson(json.decode(response.body));
  }

  Future<ResponseObj> updateProfile(UserObj userObj) async {//update profile customer dựa trên id
    int userId = await sharedPreferenceHelper.userId;
    userObj.idcustomer = userId;
    var body = json.encode(userObj);
    var _url = await sharedPreferenceHelper.endpoint + "/api/customer";
    http.Response response = await makePut(_url, body);
    return ResponseObj.fromJson(json.decode(response.body));// return code, message, data
  }

  Future<String> uploadProfile(String base64) async {
    print('user_upload_avatar $base64');
    int userId = await sharedPreferenceHelper.userId;
    var data = {"userid": userId.toString(), "image": base64};
    var _url = await sharedPreferenceHelper.endpoint +
        "/api/customer/profile/${userId.toString()}";
    return http
        .post(_url,
            headers: {"Content-Type": "application/x-www-form-urlencoded"},
            body: data)
        .then((http.Response response) {
      print("response:" + response.body);
      return response.body;
    });
  }

  Future<List<NotifyObj>> getNotify(int userId) async {
    var _url =
        await sharedPreferenceHelper.endpoint + "/api/noti/customer/$userId";
    final response = await makeRequest(_url);
    List<NotifyObj> _list = List();
    if (response.statusCode == 200) {
      ResponseObj responseObj =
          ResponseObj.fromJson(json.decode(response.body));
      _list = (responseObj.data as List)
          .map((data) => new NotifyObj.fromJson(data))
          .toList();
    } else {
      throw Exception('Failed to load data');
    }
    return _list;
  }

  Future<ResponseObj> addNotify(String message) async {
    int userId = await Utils.getUserId();
    Map data = {'message': message, 'uid': userId};
    var body = json.encode(data);
    var _url = await sharedPreferenceHelper.endpoint + "/api/common/notify/add";
    http.Response response = await makePost(_url, body);
    return ResponseObj.fromJson(json.decode(response.body));
  }

  //---VEHICLE
  static const String VEHICLE = "";

  Future<List<VehicleObj>> getvehicle() async { // lấy list vehicle
    var _url = await sharedPreferenceHelper.endpoint + "/api/vehicle";
    final response = await makeRequest(_url);
    List<VehicleObj> _list = List();
    if (response.statusCode == 200) {
      ResponseObj responseObj =
          ResponseObj.fromJson(json.decode(response.body));
      _list = (responseObj.data as List)
          .map((data) => new VehicleObj.fromJson(data))
          .toList();
    } else {
      throw Exception('Failed to load data');
    }
    return _list;
  }

//---CARD
  static const String CARD = "";

  Future<List<CardObj>> getcard(int userId) async { //get list card of customer
    var _url =
        await sharedPreferenceHelper.endpoint + "/api/card?iduser=$userId";
    final response = await makeRequest(_url);
    List<CardObj> _list = List();
    if (response.statusCode == 200) {
      ResponseObj responseObj =
          ResponseObj.fromJson(json.decode(response.body));
      _list = (responseObj.data as List)
          .map((data) => new CardObj.fromJson(data))
          .toList();
    } else {
      throw Exception('Failed to load data');
    }
    return _list;
  }

  Future<ResponseObj> addcard(CardObj obj) async {
    int userId = await sharedPreferenceHelper.userId;
    obj.iduser = userId;
    var body = json.encode(obj.toJson());
    var _url = await sharedPreferenceHelper.endpoint + "/api/card";
    http.Response response = await makePost(_url, body);
    return ResponseObj.fromJson(json.decode(response.body));
  }

  Future<ResponseObj> delcard(PlaceObj obj) async {
    var _url = await sharedPreferenceHelper.endpoint +
        "/api/customer/place/del/${obj.idplace}";
    http.Response response = await makePost(_url, null);
    return ResponseObj.fromJson(json.decode(response.body));
  }
//=========================================================================================== <REPORT>
  static const REPORT = "";

  Future<double> getRating() async {
    int userId = await Utils.getUserId();
    var _url = await sharedPreferenceHelper.endpoint +
        "/api/rating/customer/" +
        userId.toString();
    final response = await makeRequest(_url);
    double revenue = 0;
    if (response.statusCode == 200) {
      final Map parsed = json.decode(response.body);
      revenue = parsed['data']['value'].toDouble();
      print('rating' + revenue.toString());
    } else {
      throw Exception('Failed to load data');
    }
    return revenue;
  }
//=========================================================================================== <PLACE>
  static const String PLACE = "";

  Future<List<PlaceObj>> getFarPlace(int far) async { // gợi ý Favorite Place và Place đi gần đây
    int userId = await sharedPreferenceHelper.userId;
    var _url =
        await sharedPreferenceHelper.endpoint + "/api/place?idcustomer=$userId&far=$far";
    final response = await makeRequest(_url);
    List<PlaceObj> _list = List();
    if (response.statusCode == 200) {
      ResponseObj responseObj =
          ResponseObj.fromJson(json.decode(response.body));
      _list = (responseObj.data as List)
          .map((data) => new PlaceObj.fromJson(data))
          .toList();
    } else {
      throw Exception('Failed to load data');
    }
    return _list;
  }

  Future<ResponseObj> addPlace(PlaceObj place) async {// add Place
    int userId = await sharedPreferenceHelper.userId; // lấy customerid = userid
    place.idcustomer = userId;// gán biến cho bằng
    var body = json.encode(place.toJson());// mã hóa Place thành JSON
    var _url = await sharedPreferenceHelper.endpoint + "/api/place";// gán url cho biến
    http.Response response = await makePost(_url, body);
    return ResponseObj.fromJson(json.decode(response.body));
  }

  Future<ResponseObj> deletePlace(PlaceObj obj) async {// xóa place
    var _url =
        await sharedPreferenceHelper.endpoint + "/api/place/${obj.idplace}";
    http.Response response = await makeDel(_url);
    return ResponseObj.fromJson(json.decode(response.body));
  }

//=========================================================================================== <GG Map>
  static const GOOGLE = "";

  Future<List<Results>> searchPlace(String keyword) async {
    String url =
        "https://maps.googleapis.com/maps/api/place/textsearch/json?key=" +
            KEYS.keyMap +
            "&language=vi&region=VN&query=" +
            Uri.encodeQueryComponent(keyword);
    print("search >>: " + url);
    var res = await http.get(url);
    print("res " + json.decode(res.body).toString());
    if (res.statusCode == 200) {
      PlaceItemRes placeItemRes = PlaceItemRes.fromJson(json.decode(res.body));
      return placeItemRes.results;
    } else {
      return new List();
    }
  }

  Future<String> findPlaceName(LatLng latLng) async {//tìm tên Place từ kinh độ vĩ độ
    String url = "https://maps.googleapis.com/maps/api/geocode/json?key=" +
        KEYS.keyMap +
        "&latlng=" +
        latLng.latitude.toString() +
        "," +
        latLng.longitude.toString();
    print("findnameplace >>: " + url);
    var res = await http.get(url);
    print("res " + json.decode(res.body).toString());
    if (res.statusCode == 200) {
      Geoobj geoobj = Geoobj.fromJson(json.decode(res.body));
      return geoobj.results[0].formattedAddress;
    } else {
      return "";
    }
  }

  Future<String> findCity(LatLng latLng) async {
    String url = "https://maps.googleapis.com/maps/api/geocode/json?key=" +
        KEYS.keyMap +
        "&latlng=" +
        latLng.latitude.toString() +
        "," +
        latLng.longitude.toString();
    print("findnameplace >>: " + url);
    var res = await http.get(url);
    print("res " + json.decode(res.body).toString());
    if (res.statusCode == 200) {
      Geoobj geoobj = Geoobj.fromJson(json.decode(res.body));
      return geoobj.results[0].addressComponents[2].longName;
    } else {
      return "";
    }
  }

  Future<DistanttimeObj> getDistantTime(LatLng latLng1, LatLng latLng2) async {//lấy distance và time từ điểm đi tới điểm đến
    String url =
        "https://maps.googleapis.com/maps/api/distancematrix/json?key=" +
            KEYS.keyMap +
            "&origins=" +
            latLng1.latitude.toString() +
            "," +
            latLng1.longitude.toString() +
            "&destinations=" +
            latLng2.latitude.toString() +
            "," +
            latLng2.longitude.toString();
    print("gg_distanttime >>: " + url);
    var res = await http.get(url);
    print("res " + json.decode(res.body).toString());
    if (res.statusCode == 200) {
      DistanttimeObj distanttimeObj =
          DistanttimeObj.fromJson(json.decode(res.body));
      return distanttimeObj;
    } else {
      return null;
    }
  }

  //=========================================================================================== <RIDE>
  static const String RIDE = "";

  Future<RideObj> getRide(int idride) async {//get ride có cùng idride
    var _url =
        await sharedPreferenceHelper.endpoint + "/api/ride/detail/$idride";
    final response = await makeRequest(_url);
    ResponseObj responseObj;
    RideObj rideObj;
    if (response.statusCode == 200) {
      responseObj = ResponseObj.fromJson(json.decode(response.body));
      if (responseObj.code == 0) {
        rideObj = RideObj.fromJson(responseObj.data);
      }
    } else {
      throw Exception('Failed to load data');
    }
    return rideObj;
  }

  Future<ResponseObj> addRide(RideObj rideObj, int iddriver) async { // add ride mới
    int userId = await sharedPreferenceHelper.userId;
    rideObj.idcustomer = userId;
    rideObj.iddriver = iddriver;
    var body = json.encode(rideObj.toJson());
    var _url = await sharedPreferenceHelper.endpoint + "/api/ride";
    http.Response response = await makePost(_url, body);
    return ResponseObj.fromJson(json.decode(response.body));
  }

  Future<ResponseObj> updateRide(RideObj rideObj, CustomerStatus customerStatus) async {
    String status = EnumToString.parse(customerStatus);
    rideObj.status = status;
    var body = json.encode(rideObj.toJson());
    var _url = await sharedPreferenceHelper.endpoint + "/api/ride";
    http.Response response = await makePost(_url, body);
    return ResponseObj.fromJson(json.decode(response.body));
  }

  Future<ResponseObj> addRating(RatingObj obj) async {
    var body = json.encode(obj.toJson());
    obj.fromcustomer = 1;
    var _url = await sharedPreferenceHelper.endpoint + "/api/rating";
    http.Response response = await makePost(_url, body);
    return ResponseObj.fromJson(json.decode(response.body));
  }

  Future<List<HisObj>> getHistory() async {
    var userid = await sharedPreferenceHelper.userId;
    var _url =
        await sharedPreferenceHelper.endpoint + "/api/ride/customer/$userid";
    final response = await makeRequest(_url);
    List<HisObj> _list = List();
    if (response.statusCode == 200) {
      ResponseObj responseObj =
          ResponseObj.fromJson(json.decode(response.body));
      _list = (responseObj.data as List)
          .map((data) => new HisObj.fromJson(data))
          .toList();
    } else {
      throw Exception('Failed to load data');
    }
    return _list;
  }

//=========================================================================================== <TRIP>
  static const String TRIP = "";

  Future<ResponseObj> updateRequest(
      RequestObj requestObj, String status) async {
    Map data = {'id': requestObj.id, "status": status};
    var body = json.encode(data);
    var _url =
        await sharedPreferenceHelper.endpoint + "/api/trip/request/update";
    http.Response response = await makePost(_url, body);
    return ResponseObj.fromJson(json.decode(response.body));
  }

  Future<List<LogTripObj>> getTrip() async {
    int userId = await sharedPreferenceHelper.userId;
    var _url = await sharedPreferenceHelper.endpoint +
        "/api/trip/request/customer/$userId";
    final response = await makeRequest(_url);
    List<LogTripObj> _list = List();
    if (response.statusCode == 200) {
      ResponseObj responseObj =
          ResponseObj.fromJson(json.decode(response.body));
      _list = (responseObj.data as List)
          .map((data) => new LogTripObj.fromJson(data))
          .toList();
    } else {
      throw Exception('Failed to load data');
    }
    return _list;
  }

//=================================================================================== <DRIVER>
  static const String DRIVER = "";

  Future<List<DriverObj>> getNearbyDriver() async {// lấy danh sách tài xế ở gần
    int userId = await sharedPreferenceHelper.userId;
    var _url = await sharedPreferenceHelper.endpoint +
        "/api/driver/nearby?idcustomer=$userId";
    final response = await makeRequest(_url);
    List<DriverObj> _list = List();
    if (response.statusCode == 200) {
      ResponseObj responseObj =
          ResponseObj.fromJson(json.decode(response.body));
      _list = (responseObj.data as List)
          .map((data) => new DriverObj.fromJson(data))
          .toList();
    } else {
      throw Exception('Failed to load data');
    }
    return _list;
  }

  Future<List<DriverObj>> getAvailableDriver( int sex, int accept) async { // lấy danh sách tài xế đang sẵn sàng
    int userId = await sharedPreferenceHelper.userId;
    var _url = await sharedPreferenceHelper.endpoint +
        "/api/driver/available?idcustomer=$userId&sex=$sex&accept=$accept";
    final response = await makeRequest(_url);
    List<DriverObj> _list = List();
    if (response.statusCode == 200) {
      ResponseObj responseObj =
          ResponseObj.fromJson(json.decode(response.body));
      _list = (responseObj.data as List)
          .map((data) => new DriverObj.fromJson(data))
          .toList();
    } else {
      throw Exception('Failed to load data');
    }
    return _list;
  }

  Future<DriverObj> getDriverDetail(int iddriver) async {// lấy thông tin driver cụ thể
    var _url = await sharedPreferenceHelper.endpoint + "/api/driver/detail/$iddriver";
    final response = await makeRequest(_url);
    DriverObj driverObj;
    if (response.statusCode == 200) {
      final Map parsed = json.decode(response.body);
      ResponseObj responseObj = ResponseObj.fromJson(parsed);
      driverObj = DriverObj.fromJson(responseObj.data);
    } else {
      throw Exception('Failed to load data');
    }
    return driverObj;
  }

  Future<CarObj> getCar(int iddriver) async {// láy thông tin xe của tài xế
    var _url =
        await sharedPreferenceHelper.endpoint + "/api/car/driver/$iddriver";
    final response = await makeRequest(_url);
    CarObj carObj;
    if (response.statusCode == 200) {
      final Map parsed = json.decode(response.body);
      ResponseObj responseObj = ResponseObj.fromJson(parsed);
      carObj = CarObj.fromJson(responseObj.data);
    } else {
      throw Exception('Failed to load data');
    }
    return carObj;
  }

//=================================================================================== <BASIC>
  static const String BASIC = "";

  Future<ResponseObj> mail(String mail, String content) async {
    Map data = {'mail': mail, "content": content};
    var body = json.encode(data);
    var _url = await sharedPreferenceHelper.endpoint + "/api/common/mail";
    http.Response response = await makePost(_url, body);
    return ResponseObj.fromJson(json.decode(response.body));
  }

  Future<void> sendFcm(String token, String message) async { // send FCM to user token
    Map data = {'registrationToken': token, "message": message};
    var body = json.encode(data);
    var _url = await sharedPreferenceHelper.endpoint + "/api/noti/send";
    http.Response response = await makePost(_url, body);
    print(response);
  }

  Future<http.Response> makeRequest(String url) async {// Get data from api
    Log.info("calling -> " + url);
    http.Response response = await http.get(url);
    Log.obj(response.body);
    return response;
  }

  Future<http.Response> makeDel(String url) async {// delete data from api
    Log.info("calling -> " + url);
    http.Response response = await http.delete(url);
    Log.obj(response.body);
    return response;
  }

  Future<http.Response> makePost(String url, body) async {// post data to api
    Log.info("calling -> " + url);
    var response = await http.post(url,
        headers: {"Content-Type": "application/json"}, body: body);
    Log.obj(response.body);
    return response;
  }

  Future<http.Response> makePut(String url, body) async { // Put data to api
    Log.info("calling -> " + url);
    var response = await http.put(url,
        headers: {"Content-Type": "application/json"}, body: body);
    Log.obj(response.body);
    return response;
  }
}
