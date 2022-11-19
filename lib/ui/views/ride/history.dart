import 'package:flutter/material.dart';
import 'package:kf_drawer/kf_drawer.dart';
import 'package:provider_arc/core/models/his.dart';
import 'package:provider_arc/core/services/api.dart';
import 'package:provider_arc/ui/shared/app_colors.dart';
import 'package:provider_arc/ui/shared/text_styles.dart';
import 'package:provider_arc/ui/shared/ui_helpers.dart';
import 'package:provider_arc/ui/widgets/fromto2.dart';
import 'package:provider_arc/ui/widgets/loading.dart';

class HistoryView extends KFDrawerContent {
  @override
  _HistoryViewState createState() => _HistoryViewState();
}

class _HistoryViewState extends State<HistoryView> {
  List<HisObj> _list = List();
  Api api = Api();
  bool loading = true;

  @override
  void initState() {
    super.initState();
    this.getData();
  }

  void getData() async {
    List<HisObj> list = await api.getHistory();
    setState(() {
      _list = list;
      loading = false;
    });
    print('size ${_list.length}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text(
            "History",
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
            ? Loading()
            : ListView.builder(
                itemCount: _list.length,
                itemBuilder: (context, index) {
                  return Item(rideObj: _list[index]);
                },
              ));
  }
}
class Item extends StatelessWidget {
  final HisObj rideObj;

  const Item({Key key, this.rideObj}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      //color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: LightGrey,
                child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(rideObj.dprofile),
                      radius: 20.0,
                    ),
                    title: Text(
                      rideObj.driver,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      rideObj.date,
                    ),
                    trailing: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        rideObj.status == "cancel"
                            ? Column(
                          children: [
                            Text(
                              "\$ ${rideObj.price.toStringAsFixed(2)}",
                              style: new TextStyle(
                                color: Colors.grey,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                            Text(
                              "\$ 0.00",
                              style: BoldStylePri,
                            ),
                          ],
                        )
                            : Text(
                          "\$ ${rideObj.price.toStringAsFixed(2)}",
                          style: normalStyle,
                        ),
                        Text(
                          rideObj.status.toUpperCase(),
                          style: BoldStylePri,
                        )
                      ],
                    )),
              ),
              //Text(rideObj.code, ),
              FromTo2(
                from: rideObj.from,
                to: rideObj.to,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
