import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kf_drawer/kf_drawer.dart';
import 'package:mdi/mdi.dart';
import 'package:provider_arc/core/constants/app_contstants.dart';

//import 'package:provider_arc/core/constants/mockdata.dart';
import 'package:provider_arc/core/models/card.dart';
import 'package:provider_arc/core/services/api.dart';
import 'package:provider_arc/ui/shared/app_colors.dart';
import 'package:provider_arc/ui/shared/ui_helpers.dart';
import 'package:provider_arc/ui/widgets/custom/mytitle.dart';
import 'package:provider_arc/ui/widgets/loading.dart';
import 'package:provider_arc/ui/widgets/nodata.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class PaymementView extends KFDrawerContent {
  @override
  _SelectDesPageState createState() {
    return _SelectDesPageState();
  }
}

class _SelectDesPageState extends State<PaymementView> {
  final myController1 = TextEditingController();
  List<CardObj> list;
  bool loading = true;
  final Api _api = new Api();

  void initState() {
    super.initState();
    getdata();
  }

  Future<void> getdata() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int userId = prefs.getInt(KEYS.idcustomer);
    List<CardObj> _list = await _api.getcard(userId);
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
          onPressed: widget.onMenuPressed,
        ),
        actions: <Widget>[
          FlatButton.icon(
              onPressed: () {
                Navigator.pushNamed(context, RoutePaths.AddPayment)
                    .whenComplete(() => getdata());
              },
              icon: Icon(
                Icons.add,
                color: PrimaryColor,
              ),
              label: Text(
                "Add",
                style: TextStyle(color: PrimaryColor),
              ))
        ],
      ),
      body: loading
          ? Loading()
          : Container(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    MyTitle(
                      title: 'Payment Card',
                    ),
                    UIHelper.verticalSpaceSmall,
                    Expanded(
                      child: list.length == 0
                          ? Nodata()
                          : ListView.builder(
                              itemCount: list.length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    //select(index);
                                  },
                                  child: Card(
                                    child: ListTile(
                                        leading: list[index].type == 1
                                            ? Image.asset(
                                                'assets/images/master.png')
                                            : Image.asset(
                                                'assets/images/visa.png'),
                                        title: Text(list[index].number),
                                        subtitle: Text(list[index].date),
                                        trailing: Icon(
                                          Mdi.minusCircle,
                                          color: PrimaryColor,
                                        )),
                                  ),
                                );
                              },
                            ),
                    ),
                    //Spacer(),
                    /* MyButton(
                caption: 'Done',
                fullsize: true,
                onPressed: () => Navigator.pop(context, _select),
              ),*/
                  ],
                ),
              ),
            ),
    );
  }
}
