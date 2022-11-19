import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider_arc/core/models/card.dart';
import 'package:provider_arc/core/models/response.dart';
import 'package:provider_arc/core/services/api.dart';
import 'package:provider_arc/ui/shared/ui_helpers.dart';
import 'package:provider_arc/ui/widgets/custom/mydialog.dart';
import 'package:provider_arc/ui/widgets/item/itemradio2.dart';
import 'package:provider_arc/ui/widgets/my/mybutton.dart';

class Addpaymentcard extends StatefulWidget {
  @override
  _AddpaymentcardState createState() => _AddpaymentcardState();
}

class _AddpaymentcardState extends State<Addpaymentcard> {
  List<RadioModel2> _listtype = [
    RadioModel2(true, "Master", 'assets/images/master.png'),
    RadioModel2(false, "Visa", 'assets/images/visa.png'),
    // RadioModel2(false, "Paypal", 'assets/images/paypal.png'),
  ];
  int _selecttype = 0;
  bool hidepass = true;
  final TextEditingController controllerName = TextEditingController();
  final TextEditingController controllerCode = new TextEditingController();
  final TextEditingController controllerDate = new TextEditingController();
  final TextEditingController controllerCvv = new TextEditingController();
  final Api api = Api();

  select(int i) {
    debugPrint('choice $i');
    setState(() {
      _selecttype = i;
      _listtype[0].isSelected = false;
      _listtype[1].isSelected = false;
      //_listtype[2].isSelected = false;
      _listtype[i].isSelected = true;
    });
  }

  Widget buildpaytype() {
    return Container(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        RadioItem2(
          item: _listtype[0],
          onPressed: () => select(0),
        ),
        RadioItem2(
          item: _listtype[1],
          onPressed: () => select(1),
        ),
        /*  RadioItem2(
          item: _listtype[2],
          onPressed: () => select(2),
        ),*/
      ],
    ));
  }

  void initState() {
    super.initState();
    genCard();
  }

  void genCard() {
    String card =
        gen4Card() + '-' + gen4Card() + '-' + gen4Card() + '-' + gen4Card();
    print(card);
    setState(() {
      controllerCode.text = card;
    });
  }

  String gen4Card() {
    var rnd = new Random();
    var next = rnd.nextDouble() * 10000;
    while (next < 1000) {
      next *= 10;
    }
    return next.toInt().toString();
  }

  Future<void> save() async {
    if (controllerName.text.isEmpty) {
      DialogUtils.showToast("Please input name");
      return;
    }
    if (controllerCode.text.isEmpty) {
      DialogUtils.showToast("Please input card number");
      return;
    }
    if (controllerDate.text.isEmpty) {
      DialogUtils.showToast("Please input expired date");
      return;
    }
    if (controllerCvv.text.isEmpty) {
      DialogUtils.showToast("Please input CVV");
      return;
    }
    CardObj cardObj = CardObj();
    cardObj.name = controllerName.text;
    cardObj.number = controllerCode.text;
    cardObj.date = controllerDate.text;
    cardObj.cvv = controllerCvv.text;
    cardObj.type = _selecttype + 1;
    ResponseObj responseObj = await api.addcard(cardObj);
    var loginSuccess = responseObj.code == 0;
    if (loginSuccess) {
      Navigator.pop(context);
    } else {
      DialogUtils.showSimpleDialog(
        context,
        title: responseObj.message,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: new AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: new IconButton(
          icon: new Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: (Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Add payment card',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              UIHelper.verticalSpaceSmall,
              buildpaytype(),
              UIHelper.verticalSpaceSmall,
              _selecttype == 2
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("Email", style: TextStyle(color: Colors.grey)),
                        UIHelper.verticalSpaceSmall,
                        TextField(
                          controller: controllerName,
                          decoration: InputDecoration(
                              hintText: "Email",
                              hintStyle: TextStyle(color: Colors.black26),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.blueGrey, width: 5.0),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(16.0)),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 16.0)),
                        ),
                      ],
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("Name", style: TextStyle(color: Colors.grey)),
                        UIHelper.verticalSpaceSmall,
                        TextField(
                          controller: controllerName,
                          decoration: InputDecoration(
                              hintText: "Name",
                              hintStyle: TextStyle(color: Colors.black26),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.blueGrey, width: 5.0),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(16.0)),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 16.0)),
                        ),
                        UIHelper.verticalSpaceSmall,
                        Text("Credit card number",
                            style: TextStyle(color: Colors.grey)),
                        UIHelper.verticalSpaceSmall,
                        TextField(
                          controller: controllerCode,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                              hintText: "Number",
                              hintStyle: TextStyle(color: Colors.black26),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.blueGrey, width: 5.0),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(16.0)),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 16.0)),
                        ),
                        UIHelper.verticalSpaceSmall,
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text("Expired",
                                      style: TextStyle(color: Colors.grey)),
                                  UIHelper.verticalSpaceSmall,
                                  GestureDetector(
                                    onTap: () async {
                                      var datePicked =
                                          await DatePicker.showSimpleDatePicker(
                                        context,
                                        initialDate: DateTime(2022),
                                        firstDate: DateTime(2020),
                                        lastDate: DateTime(2030),
                                        dateFormat: "MMMM-yyyy",
                                        locale: DateTimePickerLocale.en_us,
                                        looping: true,
                                      );
                                      String formattedDate =
                                          DateFormat('MM/yyyy')
                                              .format(datePicked);
                                      setState(() {
                                        //_controller_date.text = datePicked.month.toString()+'/'+datePicked.year.toString();
                                        controllerDate.text = formattedDate;
                                      });
                                    },
                                    child: TextField(
                                      enabled: false,
                                      controller: controllerDate,
                                      keyboardType: TextInputType.phone,
                                      decoration: InputDecoration(
                                          hintText: "MM/YYYY",
                                          hintStyle:
                                              TextStyle(color: Colors.black26),
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.blueGrey,
                                                width: 5.0),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(16.0)),
                                          ),
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: 20.0,
                                              vertical: 16.0)),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 16,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text("CVV",
                                      style: TextStyle(color: Colors.grey)),
                                  UIHelper.verticalSpaceSmall,
                                  TextField(
                                    controller: controllerCvv,
                                    keyboardType: TextInputType.phone,
                                    decoration: InputDecoration(
                                        hintText: "CVV",
                                        hintStyle:
                                            TextStyle(color: Colors.black26),
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.blueGrey,
                                              width: 5.0),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(16.0)),
                                        ),
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 20.0, vertical: 16.0)),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
              UIHelper.verticalSpaceMedium,
              MyButton(
                caption: 'SAVE',
                fullsize: true,
                onPressed: () => save(),
              ),
            ],
          )),
        ),
      ),
    );
  }
}
