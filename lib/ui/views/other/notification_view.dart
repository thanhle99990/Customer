import 'package:flutter/material.dart';
import 'package:kf_drawer/kf_drawer.dart';
import 'package:provider_arc/core/models/notification.dart';
import 'package:provider_arc/core/services/api.dart';
import 'package:provider_arc/core/utils/device_utils.dart';
import 'package:provider_arc/ui/widgets/item/itemnotification.dart';
import 'package:provider_arc/ui/widgets/nodata.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/constants/app_contstants.dart';

class NotificationView extends KFDrawerContent {
  @override
  _ThongbaoViewState createState() {
    return _ThongbaoViewState();
  }
}

class _ThongbaoViewState extends State<NotificationView> {
  final Api api = new Api();
  var loading = true;
  List<NotifyObj> _list = [];

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void getData() async {
    int userId = await Utils.getUserId();
    List<NotifyObj> list = await api.getNotify(userId);
    setState(() {
      _list = list;
      loading = false;
    });
    print("size " + _list.length.toString());
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(KEYS.KEYSEEN, _list.length);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text(
            "Notification",
            style: TextStyle(color: Colors.black),
          ),
          leading: new IconButton(
            icon: new Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: widget.onMenuPressed,
          ),
        ),
        body: loading
            ? Center(
          child: CircularProgressIndicator(),
        )
            : _list.length == 0
            ? Nodata()
            : GestureDetector(
          onTap: () {
            this.getData();
          },
          child: ListView.separated(
            separatorBuilder: (context, index) => Divider(
              color: Colors.grey,
            ),
            itemCount: _list.length,
            itemBuilder: (context, int) {
              return ItemNotification(item: _list[int]);
            },
          ),
        ));
  }
}
