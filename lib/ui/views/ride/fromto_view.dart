import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_map_location_picker/google_map_location_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider_arc/core/constants/app_contstants.dart';
import 'package:provider_arc/core/models/FromToObj.dart';
import 'package:provider_arc/core/models/placeobj.dart';
import 'package:provider_arc/core/viewmodels/views/fromto_view_model.dart';
import 'package:provider_arc/ui/shared/app_colors.dart';
import 'package:provider_arc/ui/shared/text_styles.dart';
import 'package:provider_arc/ui/shared/ui_helpers.dart';
import 'package:provider_arc/ui/views/base_widget.dart';
import 'package:provider_arc/ui/widgets/dummy.dart';
import 'package:provider_arc/ui/widgets/item/farplaceitem.dart';

class FromToView extends StatefulWidget {
  @override
  _FromToViewState createState() => _FromToViewState();
}

class _FromToViewState extends State<FromToView> {
  bool change = false;

  PlaceObj from;
  PlaceObj to;

  @override
  Widget build(BuildContext context) {
    return BaseWidget<FromToViewModel>(
        model: FromToViewModel(),
        onModelReady: (model) => model.getData(),// get Data hiện gợi ý các Place gần đây và Favorite Place
        builder: (context, model, child) => Scaffold(
              appBar: new AppBar(
                backgroundColor: Colors.white,
                elevation: 0,
                leading: new IconButton(
                  icon: new Icon(
                    Icons.close,// hiện icon close
                    color: Colors.black,
                  ),
                  onPressed: () => Navigator.of(context).pop(),// trờ về trang trước(none)
                ),
              ),
              body: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),

                ///color: Colors.grey,
                child: Column(
                  children: [
                    UIHelper.verticalSpaceSmall,// box nhỏ height = 10
                    Container(
                      color: Colors.white,
                      child: ListTile(
                        leading: Icon(
                          Icons.radio_button_checked,// icon chấm đỏ
                          color: PrimaryColor,
                        ),
                        title: GestureDetector(
                          onTap: () => {},// bấm vào ko đi đâu cả
                          child: Text(
                            change ? from.address : "Current Location",// hiện địa chỉ muốn bắt đầu - nếu change là true thì trả về from.address và false thì trả về "Current Location" - change ở đây là false
                            textAlign: TextAlign.start,
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                        trailing: GestureDetector(
                          onTap: () async {
                            print('click'); // in click trong console để dễ debug
                            LocationResult result = await showLocationPicker(
                              context,
                              KEYS.keyMap,
                              initialCenter: LatLng(10.8777, 106.8016), // hiện gợi ý ở vị trí kinh độ và vĩ độ này đầu tiên
                              //initialCenter: LatLng(from.lng, from.lat),
                              automaticallyAnimateToCurrentLocation: true, // tự động tìm vị trí của thiết bị
                              myLocationButtonEnabled: true,
                              layersButtonEnabled: true,
                              desiredAccuracy: LocationAccuracy.best,
                            );
                            print("result = $result"); // in ra địa chỉ của nơi này
                            PlaceObj place = PlaceObj(); // tạo object Place
                            place.address = result.address;
                            place.lat = result.latLng.latitude;
                            place.lng = result.latLng.longitude;
                            place.type = 3; // type = 3 là địa chỉ đã đi gần đây
                            from = place;
                            setState(() {
                              change = true; // đổi change thành true, ở đây có thể hiện địa chỉ mong muốn
                            });
                            //selectPlace(place);
                          },
                          child: Text(
                            "Change",
                            style: BoldStylePri,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 1,
                      color: LightColor,
                      margin: EdgeInsets.only(left: 80, right: 20),// giãn cách ra một khoảng cách với GestureDetector dưới
                    ),
                    GestureDetector(
                      onTap: () async {
                        print('click');
                        LocationResult result = await showLocationPicker(
                          context,
                          KEYS.keyMap,
                          //initialCenter:
                              //LatLng(10.02435490, 105.75610270),
                          initialCenter: LatLng(10.8777,106.8016), // hiện gợi ý ở vị trí kinh độ và vĩ độ này đầu tiên
                          //initialCenter: LatLng(from.lng, from.lat),
                          automaticallyAnimateToCurrentLocation: true,
                          myLocationButtonEnabled: true,
                          layersButtonEnabled: true,
                          desiredAccuracy: LocationAccuracy.best,
                        );
                        print("result = $result");
                        PlaceObj place = PlaceObj();
                        place.address = result.address;
                        place.lat = result.latLng.latitude;
                        place.lng = result.latLng.longitude;
                        place.type = 3; // type = 3 là địa chỉ đã đi gần đây
                        done(place);
                      },
                      child: Container(
                        color: Colors.white,
                        child: ListTile(
                            leading: Icon(
                              Icons.crop_square,
                              color: Dark,
                            ),
                            title: to == null // nếu địa chỉ đi tới bằng null (True) thì chạy Text 1, False chạy Text 2
                                ? Text(
                                    'Pick drop location',
                                    style: TextStyle(
                                      color: Colors.grey,
                                    ),
                                  )
                                : Text(
                                    'new place', // bấm vào hiện new place
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  )),
                      ),
                    ),
                    Divider(
                      height: 10,
                      color: Colors.grey, // khoảng cách với bên dưới
                    ),
                    model.busy // model.busy = true thì chạy Dummy, false thì chạy ListView.builder
                        ? Dummy()
                        : ListView.builder(
                            shrinkWrap: true,
                            itemCount: model.list1.length,
                            itemBuilder: (context, index) => FarPlaceItem( // hiện ra list Favorite Place
                              obj: model.list1[index],
                              enable: false,
                              onPressed: () {
                                done(model.list1[index]);
                              },
                            ),
                          ),
                    Divider(
                      height: 10,
                      color: Colors.grey,
                    ),
                    model.busy
                        ? Dummy()
                        : ListView.builder(
                            shrinkWrap: true,
                            itemCount: model.list0.length,
                            itemBuilder: (context, index) => InkWell(// hiện list Place đi gần đây
                              onTap: () {
                                done(model.list0[index]);// hiện xong thì trở ngược lại trang trước
                              },
                              child: buildItem(//widget cho Place đi gần đây
                                model.list0[index],
                              ),
                            ),
                          ),
                  ],
                ),
              ),
            ));
  }

  Widget buildItem(PlaceObj obj) {//xây dựng widget cho Place đi gần đây
    return Column(
      children: [
        ListTile(
          leading: Icon(
            obj.type == 3 ? Icons.history : CupertinoIcons.location, // type bằng 3 thì hiện icon history ko thì ngược lại
            color: PrimaryColor,
          ),
          //title: Text(obj.name),
          subtitle: Text(obj.address),// hiện địa chỉ của Place
        ),
        //MyDivider()
      ],
    );
  }

  void done(PlaceObj obj) {// trở ngược lại trang trước
    FromtoObj fromtoObj = FromtoObj(from, obj);
    Navigator.pop(context, fromtoObj);
  }
}
