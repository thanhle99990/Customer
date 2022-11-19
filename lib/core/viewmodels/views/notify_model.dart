import 'package:flutter/material.dart';
import 'package:provider_arc/core/constants/app_contstants.dart';
import 'package:provider_arc/core/models/notification.dart';
import 'package:provider_arc/core/services/api.dart';
import 'package:provider_arc/core/utils/device_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotifyModel extends ChangeNotifier {
  int _notseen = 0;
  int _seen = 0;
  Api _api = Api();

  int get notseen => _notseen;

  NotifyModel() {
    getNotify();
  }

  Future getNotify() async {
    int userId = await Utils.getUserId();
    List<NotifyObj> list = await _api.getNotify(userId);
    print("size _listnotification:" + list.length.toString());
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final seen = prefs.getInt(KEYS.KEYSEEN) ?? 0;
    _seen = seen;
    print('seen: $_seen');
    _notseen = list.length - seen;
    print('notseen: $_notseen');
    notifyListeners();
  }

  void saveSeen() async {
    _notseen = 0;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(KEYS.KEYSEEN, _seen);
    notifyListeners();
  }
}
