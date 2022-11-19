import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kf_drawer/kf_drawer.dart';
import 'package:provider_arc/core/constants/enum.dart';
import 'package:provider_arc/core/utils/log.dart';
import 'package:provider_arc/core/viewmodels/views/map_view_model.dart';
import 'package:provider_arc/ui/views/base_widget.dart';
import 'package:provider_arc/ui/views/home/state/accept.dart';
import 'package:provider_arc/ui/views/home/state/waiting.dart';
import 'package:provider_arc/ui/widgets/custom/mydialog.dart';
import 'package:provider_arc/ui/widgets/dummy.dart';
import 'package:provider_arc/ui/widgets/loading.dart';

import 'state/book.dart';
import 'state/cancel.dart';
import 'state/none.dart';
import 'state/rating.dart';
import 'state/tbao.dart';

// ignore: must_be_immutable
class HomeView extends KFDrawerContent {
  HomeView({
    Key key,
  });

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {


  @override
  Widget build(BuildContext context) {
    return BaseWidget<MapViewModel>(
        model: MapViewModel(),
        onModelReady: (model) => model.init(),
        builder: (context, model, child) => WillPopScope(
            onWillPop: () => _onWillPop(model),//giúp ngăn ko hiện nút quay lại
            child: Scaffold(
              backgroundColor: Colors.white,
              body: SafeArea(//SafeArea giúp ngăn tràn viền, ko bị chặn bỏi thứ gì cả https://www.tra-loi-cau-hoi-phat-trien-web.com/vi/flutter/su-dung-safearea-trong-flutter/837540507/
                child: Stack(
                  children: <Widget>[
                    model.currentPosition == null
                        ? Loading() // hiển thị màn hình load chấm đỏ
                        : GoogleMap( //https://pub.dev/documentation/google_maps_flutter/latest/google_maps_flutter/GoogleMap-class.html
                            initialCameraPosition: CameraPosition(
                                target: model.currentPosition,
                                zoom: model.currentZoom),
                            onMapCreated: model.onMapCreated, //tạo map và hiển trị marker của customer
                            mapType: MapType.normal,
                            rotateGesturesEnabled: true, //xoay
                            tiltGesturesEnabled: true, //nghiêng
                            zoomGesturesEnabled: true, //dùng tay phóng to thu nhỏ được
                            zoomControlsEnabled: false, //không có nút phóng to thu nhỏ
                            markers: model.markers, // các điểm đánh dấu trên bảng đồ
                            onCameraMove: model.onCameraMove, // camera di chuyển trên map
                            polylines: model.polyLines, // đường đa giác trên bảng đồ
                          ),
                    model.customerstatus == CustomerStatus.none // mở đầu bằng status none
                        ? None(
                            model: model, // model của none bằng model home_view
                            onMenuPressed:widget.onMenuPressed
                          )
                        : Dummy(),
                    model.customerstatus == CustomerStatus.book
                        ? Book(
                            model: model,
                          )
                        : Dummy(),
                    model.customerstatus == CustomerStatus.waiting ||
                            model.customerstatus == CustomerStatus.booking
                        ? Waiting(
                            model: model,
                          )
                        : Dummy(),
                    model.customerstatus == CustomerStatus.gotopickup ||
                            model.customerstatus == CustomerStatus.arrived ||
                            model.customerstatus == CustomerStatus.beginride
                        ? Accept(
                            model: model,
                          )
                        : Dummy(),
                    model.customerstatus == CustomerStatus.cancel
                        ? Cancel(
                            model: model,
                          )
                        : Dummy(),
                    model.customerstatus == CustomerStatus.rating
                        ? Rating(
                            model: model,
                          )
                        : Dummy(),
                    model.tbaoObj.isshow
                        ? Tbao(
                            model: model,
                          )
                        : Dummy(),
                  ],
                ),
              ),
              //key: _key,
            )));
  }

  @override
  void dispose() {
    super.dispose();
  }

  // ignore: missing_return
  Future<bool> _onWillPop(MapViewModel model) {
    if (model.customerstatus == CustomerStatus.none) {
      DialogUtils.showCustomDialog(context, okBtnFunction: () {
        Navigator.of(context).pop(false);
      }, title: "Exit app?");
    }
    if (model.customerstatus == CustomerStatus.book) {
      DialogUtils.showCustomDialog(context, okBtnFunction: () {
        model.setBusy(false);
        model.cancelBooking();
        Navigator.of(context).pop(false);
      }, title: "Cancel booking?");
    }
  }
}
