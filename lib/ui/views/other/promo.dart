import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kf_drawer/kf_drawer.dart';
import 'package:mdi/mdi.dart';
import 'package:provider_arc/ui/shared/app_colors.dart';
import 'package:provider_arc/ui/shared/ui_helpers.dart';
import 'package:provider_arc/ui/widgets/custom/mydialog.dart';
import 'package:provider_arc/ui/widgets/custom/mytext.dart';

// ignore: must_be_immutable
class PromoView extends KFDrawerContent {
  @override
  _SelectDesPageState createState() {
    return _SelectDesPageState();
  }
}

class _SelectDesPageState extends State<PromoView> {
  //List<Results> mylist = [];

  final TextEditingController controllerPromo = new TextEditingController();

  void initState() {
    super.initState();
    //searchPlace();
  }

  Widget _buildList(context) {
    return Container(
      padding: EdgeInsets.all(8),
      color: LightColor,
      child: ListView.builder(
        // Must have an item count equal to the number of items!
        itemCount: 3,
        // A callback that will return a widget.
        itemBuilder: (context, int) {
          // In our case, a DogCard for each doggo.
          return _buildItem();
        },
      ),
    );
  }

  Widget _buildItem() {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: InkWell(
        onTap: () => {Navigator.of(context).pop(1)}, // lùi về
        child: Container(
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Container(
                height: 90,
                width: 90,
                padding: EdgeInsets.all(8),
                decoration: new BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      new BorderRadius.all(const Radius.circular(16.0)),
                ),
                child: new Center(
                    child: CircleAvatar(
                  radius: 30.0,
                  backgroundColor: myBackgroundlight,
                  child: Icon(
                    Mdi.sale, // icon sale màu primary
                    size: 30,
                    color: PrimaryColor,
                  ),
                )),
              ),
              DottedBorder(
                padding: EdgeInsets.all(0),
                color: Colors.black12,
                //strokeWidth: 1,
                child: SizedBox(
                  height: 70,
                  width: 1,
                ),
              ),
              Expanded(
                child: Container(
                  height: 100,
                  padding: EdgeInsets.all(14),
                  decoration: new BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        new BorderRadius.all(const Radius.circular(16.0)),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "10% sale off",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        "Valid to end of thesis",
                        style: TextStyle(color: Colors.grey),
                      ),
                      Align(
                          child: Text(
                            "Use now",
                            style: TextStyle(
                                color: PrimaryColor,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                          alignment: Alignment.centerRight),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
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
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () => Navigator.of(context).pop(),// lùi về
        ),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 16, top: 16),
              child: MyH1(
                text: "Add promo code",
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: controllerPromo,
                      decoration: InputDecoration(
                          hintText: "Enter promotion code",
                          hintStyle: TextStyle(color: Colors.black26),
                          border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: LightGrey, width: 5.0),
                            borderRadius:
                                BorderRadius.all(Radius.circular(12.0)),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 16.0)),
                    ),
                  ),
                  UIHelper.horizontalSpaceSmall,
                  FlatButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14.0),
                      side: BorderSide(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                    ),
                    //color: Colors.white,
                    disabledColor: Colors.grey,
                    disabledTextColor: Colors.black,
                    padding: EdgeInsets.fromLTRB(24, 12, 24, 12),
                    onPressed: () {
                      DialogUtils.showToast("Invalid Promo code");
                    },
                    child: Text(
                      "Apply",
                      style: TextStyle(fontSize: 20.0, color: Colors.grey),
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              color: Colors.grey,
            ),
            Expanded(child: _buildList(context))
          ],
        ),
      ),
    );
  }
}
