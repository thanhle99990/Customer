import 'package:flutter/material.dart';
import 'package:mdi/mdi.dart';
import 'package:provider_arc/core/models/FromToObj.dart';
import 'package:provider_arc/core/viewmodels/views/map_view_model.dart';
import 'package:provider_arc/ui/shared/app_colors.dart';
import 'package:provider_arc/ui/shared/ui_helpers.dart';
import 'package:provider_arc/ui/views/ride/fromto_view.dart';
import 'package:provider_arc/ui/widgets/mylocation.dart';
import 'package:url_launcher/url_launcher.dart';

class None extends StatelessWidget {
  final MapViewModel model;
  final GestureTapCallback onMenuPressed; // nhận diện khi bấm vào nút menu

  const None({Key key, this.model, this.onMenuPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 8, top: 16),
              child: IconButton(
                icon: Icon(
                  Icons.menu, // icon menu có sẵn
                  color: Colors.black,
                  size: 32,
                ),
                onPressed: onMenuPressed,
              ),
            ),
          ],
        ),
        Spacer(),

        Padding(
          padding: const EdgeInsets.all(16.0),
          child: MyLocation( // bấm icon my location để chỉnh map về vị trí customer
            model: model,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(16),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 2,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: ListTile(
                leading: Icon(
                  Icons.search,
                  color: PrimaryColor,
                ),
                title: GestureDetector(// nhận diện khi bấm vào
                    onTap: () => {goPickAddress(model, context)},// bấm vào sẽ chạy function goPickAddress
                    child: Text(
                      "Where are you going ?",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ))),
          ),
        ),
        UIHelper.verticalSpaceMedium // tạo size box độ cao vừa = 30
      ],
    );
  }

  Future<void> goPickAddress(MapViewModel model, BuildContext context) async {
    var result = await Navigator.push( // result = FromtoObj để lấy đc vị trí bắt đầu và kết thúc
        context,
        new MaterialPageRoute(
          builder: (BuildContext context) => FromToView(), // chuyển tới FromToView
        )) as FromtoObj;
    //print('result:' + json.encode(result));
    if (result != null) {
      model.selectDestination(result.from, result.to);//chạy xong chuyển sang state book
    }
  }

  Future<void> _whatsapp() async {
    String url = "whatsapp://send?phone=349519195";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
