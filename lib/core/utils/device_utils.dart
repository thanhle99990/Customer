//
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider_arc/core/constants/app_contstants.dart';
import 'package:provider_arc/core/models/distnattime.dart';
import 'package:provider_arc/core/models/driver.dart';
import 'package:provider_arc/core/services/api.dart';
import 'package:provider_arc/core/utils/log.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Utils {
  Api api = Api();

  static Future<int> calKm(LatLng _from, LatLng _to) async {
    if (_from == null) return 0;
    if (_to == null) return 0;
    Api api = Api();
    int km = 900000;
    DistanttimeObj distanttimeObj = await api.getDistantTime(_from, _to);
    //print(json.encode(distanttimeObj));
    try {
      km = distanttimeObj.rows[0].elements[0].distance.value;
    } catch (error) {
      return 900000;
    }
    return km;
  }

  static Future<DriverObj> findNearestDriver( // tìm ra tài xế gần nhất
      List<DriverObj> _nearDrivers, LatLng pickLocation, int settingkm) async {
    int tmp = 100000;
    int index = 0;
    int kq = -1;
    int maxkm = settingkm * 1000;
    DriverObj currDriverObj;
    try {
      for (DriverObj driver in _nearDrivers) {
        LatLng to = LatLng(driver.latitude, driver.longitude);
        int km = await Utils.calKm(pickLocation, to); // trả về khoảng cách giữa from và to - vị trí đón và tài xế
        print('${driver.iddriver}: $km');
        Log.info('maxkm $maxkm');
        Log.info('driver km $km');
        if (km < maxkm && km < tmp) {
          tmp = km;
          kq = index;
          currDriverObj = driver;
        }
        index++;
      }
    } catch (error) {
      kq = -1;
    }
    //print('near by driver: $kq :' + _nearDrivers[kq].name);
    return currDriverObj;
  }

  static Future<int> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();// tạo một SharedPreference rồi lưu vào prefs, nó vẫn lưu ngay cả khi tắt ứng dụng
    int userid = prefs.getInt(KEYS.idcustomer);// cho userid bằng pref lấy dữ liệu từ Idcustomer để mốt khỏi phải đăng nhập lại
    return userid;
  }

  static Future<String> getEndpoint() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String endpoint = prefs.getString(KEYS.endpoint);
    return endpoint;
  }

  String gen4Card() {
    var rnd = new Random();
    var next = rnd.nextDouble() * 10000;
    while (next < 1000) {
      next *= 10;
    }
    return next.toInt().toString();
  }

  static void logIt(String log) {
    print(log);
  }

  static void logItdata(String log, dynamic data) {
    print(log + " : $data");
  }

  // !DECODE POLY
  static List decodePoly(String poly) {
    var list = poly.codeUnits;
    var lList = new List();
    int index = 0;
    int len = poly.length;
    int c = 0;
    // repeating until all attributes are decoded
    do {
      var shift = 0;
      int result = 0;

      // for decoding value of one attribute
      do {
        c = list[index] - 63;
        result |= (c & 0x1F) << (shift * 5);
        index++;
        shift++;
      } while (c >= 32);
      /* if value is negative then bitwise not the value */
      if (result & 1 == 1) {
        result = ~result;
      }
      var result1 = (result >> 1) * 0.00001;
      lList.add(result1);
    } while (index < len);

    /*adding to previous value as done in encoding */
    for (var i = 2; i < lList.length; i++) lList[i] += lList[i - 2];

    print(lList.toString());

    return lList;
  }

  static List<LatLng> convertToLatLng(List points) {
    List<LatLng> result = <LatLng>[];
    for (int i = 0; i < points.length; i++) {
      if (i % 2 != 0) {
        result.add(LatLng(points[i - 1], points[i]));
      }
    }
    return result;
  }

  static Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    Codec codec = await instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ImageByteFormat.png))
        .buffer
        .asUint8List();
  }
}

/// Helper class for device related operations.
///
class DeviceUtils {
  static hideKeyboard(BuildContext context) {
    FocusScope.of(context).unfocus();
  }

  static double getScaledSize(BuildContext context, double scale) =>
      scale *
      (MediaQuery.of(context).orientation == Orientation.portrait
          ? MediaQuery.of(context).size.width
          : MediaQuery.of(context).size.height);

  static double getScaledWidth(BuildContext context, double scale) =>
      scale * MediaQuery.of(context).size.width;

  static double getScaledHeight(BuildContext context, double scale) =>
      scale * MediaQuery.of(context).size.height;
}
