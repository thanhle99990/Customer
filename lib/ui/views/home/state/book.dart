import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mdi/mdi.dart';
import 'package:provider_arc/core/constants/app_contstants.dart';
import 'package:provider_arc/core/models/gender.dart';
import 'package:provider_arc/core/models/vehicle.dart';
import 'package:provider_arc/core/utils/device_utils.dart';
import 'package:provider_arc/core/viewmodels/views/map_view_model.dart';
import 'package:provider_arc/ui/shared/app_colors.dart';
import 'package:provider_arc/ui/shared/text_styles.dart';
import 'package:provider_arc/ui/shared/ui_helpers.dart';
import 'package:provider_arc/ui/widgets/custom/mycontainer.dart';
import 'package:provider_arc/ui/widgets/custom/mydialog.dart';
import 'package:provider_arc/ui/widgets/custom/mydivider.dart';
import 'package:provider_arc/ui/widgets/custom/myiconvalue.dart';
import 'package:provider_arc/ui/widgets/dummy.dart';
import 'package:provider_arc/ui/widgets/loading.dart';
import 'package:provider_arc/ui/widgets/my/mybutton.dart';
import 'package:provider_arc/ui/widgets/mylocation.dart';

class Book extends StatefulWidget {
  final MapViewModel model;

  const Book({Key key, this.model}) : super(key: key);

  @override
  _BookState createState() => _BookState(model);
}

class _BookState extends State<Book> {
  List<Gender> gender = [
    Gender(name: 'Female', value: 0),
    Gender(name: 'Male', value: 1),
    Gender(name: 'Both', value: 2)
  ];
  final MapViewModel model;
  int selectCar;
  int selectPayment = 0;
  int promo = 0;
  int accept = 2;

  _BookState(this.model);

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: ListTile(
            leading: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(color: Colors.black12, spreadRadius: 1),
                ],
              ),
              child: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: PrimaryColor,
                ),
                onPressed: () {
                  DialogUtils.showCustomDialog(context, title: "Cancel ride?",
                      okBtnFunction: () {
                    Navigator.pop(context); //nút lùi về
                    model.setBusy(false);
                    model.backNone();
                  });
                },
              ),
            ),
            trailing: Text(
              model.rideobj.kmtext + ' | ' + model.rideobj.timetext, // hiện quãng đường và thời gian
              style: BoldStylePri,
            ),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: MyLocation( //icon location
                model: widget.model,
              ),
            ),
            MyContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  UIHelper.verticalSpaceSmall,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: SizedBox(
                      height: 110,
                      child: ListView.builder(
                          itemCount: model.listVehicle.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: ((context, index) {
                            final VehicleObj item = model.listVehicle[index];
                            return InkWell(
                                onTap: () {
                                  setState(() {
                                    selectCar = index;
                                    model.selectCar(item); //chọn vehicle
                                  });
                                },
                                child: VehicleItem(
                                  item: item,
                                  select: selectCar == index,
                                ));
                          })),
                    ),
                  ),
                  MyDivider(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            var result = await Navigator.pushNamed(
                                context, RoutePaths.SelectPayment); // chuyển tới trang selectPayment
                            print('type=$result');
                            if (result != null) {
                              setState(() {
                                selectPayment = result;
                              });
                              model.setPayment(result);
                            }
                          },
                          child: selectPayment == 0 // nếu bằng 0 thì hiển thị cash không thì hiển thị icon card
                              ? MyIconValue(
                                  icon: Mdi.cash,
                                  title: "Cash",
                                )
                              : MyIconValue(
                                  icon: Icons.credit_card,
                                  title: "Card",
                                ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            var result = await Navigator.pushNamed(
                                context, RoutePaths.Promo); // chuyển tới trang promo
                            if (result != null) {
                              setState(() {
                                promo = result;
                              });
                              model.setPayment(result);
                            }
                          },
                          child: MyIconValue(
                            icon: Mdi.sale,
                            title: promo == 0 ? "Promo code" : "10%", // nếu promo bằng 0 thì in promocode còn ko thì in 10%
                          ),
                        ),
                        /*model.userObj.sex == 1
                            ? Dummy()
                            : DropdownButton(
                                items: gender.map((item) {
                                  return new DropdownMenuItem(
                                    child: new Text(item.name),
                                    value: item.value,
                                  );
                                }).toList(),
                                onChanged: (newVal) {
                                  setState(() {
                                    accept = newVal;
                                  });
                                  model.rideobj.sex = newVal;
                                },
                                value: accept,
                              ),*/
                      ],
                    ),
                  ),
                  model.busy
                      ? Loading(
                          small: true,
                        )
                      : Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: MyButton( // Nút "Book Now"
                            onPressed: () async {
                              if (selectCar == null) {
                                DialogUtils.showSimpleDialog(context,
                                    title: "Please select car");
                                return;
                              }
                              model.setBusy(true);
                              bool check = await model.preBook(accept); // tìm ra tài xế available và gần nhất
                              if (!check) {
                                model.setBusy(false);
                                DialogUtils.showSimpleDialogOK(context,
                                    title: "Not found any driver at this time", // nếu ko thỏa điều kiện thì in lỗi
                                    okBtnFunction: () {
                                  Navigator.pop(context); // và trở về trang trước
                                  //model.backNone();
                                });
                              } else {
                                await model.book(); // send FCM to driver và chuyển sang state Waiting
                              }
                              model.setBusy(false);
                            },
                            fullsize: true,
                            caption: "BOOK NOW",
                          ),
                        )
                ],
              ),
            )
          ],
        ),
      ],
    );
  }
}

class VehicleItem extends StatelessWidget {
  final VehicleObj item;
  final bool select;

  const VehicleItem({Key key, this.item, this.select}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: DeviceUtils.getScaledWidth(context, 3 / 10),
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            child: Image.network(item.image),
            height: 50,
          ),
          Container(
            color: select ? PrimaryColor : Colors.white,
            child: SizedBox(
              height: 4,
              width: double.infinity,
            ),
          ),
          UIHelper.verticalSpaceSmall,
          Text(
            item.typename.toUpperCase(),
            style: TextStyle(
                color: Colors.grey, fontSize: 11, fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Text(
              '\$' + item.price.toStringAsFixed(2),
              style: TextStyle(color: Dark, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      )),
    );
  }
}
