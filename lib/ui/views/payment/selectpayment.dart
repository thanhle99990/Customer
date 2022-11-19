import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kf_drawer/kf_drawer.dart';
import 'package:provider_arc/core/constants/app_contstants.dart';
import 'package:provider_arc/core/models/card.dart';
import 'package:provider_arc/core/services/api.dart';
import 'package:provider_arc/ui/shared/ui_helpers.dart';
import 'package:provider_arc/ui/widgets/custom/mytitle.dart';
import 'package:provider_arc/ui/widgets/loading.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class SelectPaymementView extends KFDrawerContent {
  @override
  _SelectDesPageState createState() {
    return _SelectDesPageState();
  }
}

class _SelectDesPageState extends State<SelectPaymementView> {
  final myController1 = TextEditingController();
  List<CardObj> list;
  bool loading = true;
  final Api _api = new Api();

  void initState() {
    super.initState();
    getdata();
  }

  Future<void> getdata() async { // get cash và list card
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int userId = prefs.getInt(KEYS.idcustomer);
    List<CardObj> _list = await _api.getcard(userId);
    CardObj cardObj = CardObj();
    cardObj.number = "Cash";
    cardObj.date = "Default";
    cardObj.type = 0;
    _list.insert(0, cardObj); //thêm cash vào list
    setState(() {
      list = _list;
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: new AppBar(
        //title: new Text('Name here'),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: new IconButton(
          icon: new Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () => Navigator.of(context).pop(), //lùi về
        ),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              MyTitle(
                title: 'Select Payment',
              ),
              UIHelper.verticalSpaceSmall,
              loading
                  ? Loading()
                  : Expanded(
                      child: ListView.builder(
                        itemCount: list.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Navigator.of(context).pop(index); //bấm chọn ròi lùi về trang trước
                            },
                            child: Card(
                              child: ListTile(
                                leading: list[index].type == 0 // nếu type bằng 0 thì chạy cash
                                    ? Image.asset('assets/images/cash.png')
                                    : list[index].type == 1 //nếu type = 1 thì chạy card master card
                                        ? Image.asset(
                                            'assets/images/master.png')
                                        : Image.asset('assets/images/visa.png'), // type = 2 thì là visa card
                                title: Text(list[index].number),
                                subtitle: Text(list[index].date),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
