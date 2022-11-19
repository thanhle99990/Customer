import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:provider_arc/core/constants/enum.dart';
import 'package:provider_arc/core/models/userobj.dart';
import 'package:provider_arc/core/utils/device_utils.dart';
import 'package:provider_arc/core/viewmodels/views/map_view_model.dart';
import 'package:provider_arc/ui/shared/app_colors.dart';
import 'package:provider_arc/ui/shared/text_styles.dart';
import 'package:provider_arc/ui/shared/ui_helpers.dart';
import 'package:provider_arc/ui/views/chat/chat_screen.dart';
import 'package:provider_arc/ui/widgets/custom/mycontainer.dart';
import 'package:provider_arc/ui/widgets/dummy.dart';
import 'package:provider_arc/ui/widgets/fromto2.dart';
import 'package:provider_arc/ui/widgets/mylocation.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:url_launcher/url_launcher.dart';

class Accept extends StatefulWidget {
  final MapViewModel model;

  const Accept({Key key, this.model}) : super(key: key);

  @override
  _AcceptState createState() => _AcceptState(model);
}

class _AcceptState extends State<Accept> {
  final MapViewModel model;

  _AcceptState(this.model);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListTile(
          title: Text(
            "${model.driverstring.toUpperCase()}",// hiển thị thông báo "tài xế đang tới"
            style: BoldStylePri,
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: MyLocation(
                    model: model,
                  ),
                )
              ],
            ),
            SlidingUpPanel(
              minHeight: 160,
              maxHeight: DeviceUtils.getScaledHeight(context, 6 / 10),
              panel: buildPanel(),
              body: Center(
                child: Text("This is the Widget behind the sliding panel"),
              ),
            )
          ],
        ),
      ],
    );
  }

  Widget buildPanel() {
    return Center(
      child: Column(
        children: [
          MyContainer(
              child: Column(children: <Widget>[
            UIHelper.verticalSpaceSmall,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 60,
                  height: 5,
                  color: Grey,
                ),
              ],
            ),
            ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage("${model.currentDriver.profile}"), // hiển thị profile = ảnh của tài xế
                radius: 20.0,
              ),
              title: Text(
                "${model.currentDriver.name} ", // tên tài xế
                style: TitleStyle,
              ),
              trailing: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      model.car.model.toUpperCase(), // model của xe
                      style: TitleStyle,
                    ),
                    Text(
                      model.car.plate.toUpperCase(), // biển số xe
                    )
                  ],
                ),
              ),
            ),
            Divider(),
            model.customerstatus == CustomerStatus.beginride // begin ride thì hiện Dummy không thì hiện cái dưới
                ? Dummy()
                : Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Item2(
                          icon: LineAwesomeIcons.close,
                          text: "Cancel",
                          onPressed: () {
                            widget.model.cancelConfirm(); // status = cancel
                          },
                        ),
                        Item2(
                          icon: LineAwesomeIcons.wechat,
                          text: "Message",
                          onPressed: () {
                            UserObj item = UserObj();
                            item.idcustomer = model.currentDriver.iddriver;
                            item.name = model.currentDriver.name;
                            item.phone = model.currentDriver.phone;
                            item.profile = model.currentDriver.profile;
                            item.token = model.currentDriver.token;

                            Navigator.push(
                                context,
                                new MaterialPageRoute(
                                    builder: (context) => ChatScreen(
                                          userObj: item,
                                        )));
                          },
                        ),
                        Item2(
                          icon: LineAwesomeIcons.phone,
                          text: "Call",
                          onPressed: () {
                            print('call click');
                            launch("tel://" + widget.model.currentDriver.phone);
                          },
                        ),
                      ],
                    ),
                  ),
          ])),
          Column(
            children: <Widget>[
              UIHelper.verticalSpaceSmall,
              FromTo2( // widget hiển thị điểm đi và đến
                from: model.rideobj.from,
                to: model.rideobj.to,
              ),
              UIHelper.verticalSpaceSmall,
              Divider(
                height: 1,
                //color: Colors.black,
              ),
              UIHelper.verticalSpaceSmall,
              Row(  // hiển thị quãng đường thời gian và tiền
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Item4(
                    icon: FontAwesomeIcons.route,
                    text: model.rideobj.kmtext,
                  ),
                  Item4(
                    icon: FontAwesomeIcons.clock,
                    text: model.rideobj.timetext,
                  ),
                  Item4(
                      icon: FontAwesomeIcons.moneyBillAlt,
                      text: model.rideobj.price.toStringAsFixed(2) + '\$'),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}

class Item4 extends StatelessWidget {
  final IconData icon;
  final String text;

  const Item4({Key key, this.icon, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[Icon(icon), UIHelper.horizontalSpaceSmall, Text(text)],
    );
  }
}

class Item2 extends StatelessWidget {
  final IconData icon;
  final String text;
  final GestureTapCallback onPressed;

  const Item2({Key key, this.icon, this.text, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: onPressed,
        child: Row(
          children: <Widget>[
            Icon(icon),
            UIHelper.horizontalSpaceSmall,
            Text(text)
          ],
        ),
      ),
    );
  }
}
