import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kf_drawer/kf_drawer.dart';
import 'package:provider_arc/core/constants/app_contstants.dart';
import 'package:provider_arc/core/viewmodels/views/place_view_model.dart';
import 'package:provider_arc/ui/shared/app_colors.dart';
import 'package:provider_arc/ui/shared/ui_helpers.dart';
import 'package:provider_arc/ui/views/base_widget.dart';
import 'package:provider_arc/ui/widgets/custom/mydialog.dart';
import 'package:provider_arc/ui/widgets/custom/mytext.dart';
import 'package:provider_arc/ui/widgets/item/farplaceitem.dart';
import 'package:provider_arc/ui/widgets/loading.dart';
import 'package:provider_arc/ui/widgets/nodata.dart';

// ignore: must_be_immutable
class FavoriteView extends KFDrawerContent {
  @override
  _SelectDesPageState createState() {
    return _SelectDesPageState();
  }
}

//GlobalKey<FarPlaceListState> globalKey = GlobalKey();

class _SelectDesPageState extends State<FavoriteView> {
  @override
  Widget build(BuildContext context) {
    return BaseWidget<PlaceViewModel>(
        model: PlaceViewModel(),
        onModelReady: (model) => model.getData(),
        builder: (context, model, child) => Scaffold(
            appBar: new AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              leading: new IconButton(
                icon: new Icon(
                  Icons.arrow_back,
                  color: Dark,
                ),
                onPressed: widget.onMenuPressed,
              ),
              actions: [
                GestureDetector(
                  onTap: () {
                    /* Navigator.of(context)
                        .push(
                      MaterialPageRoute(
                        builder: (context) => AddNewPlaceView(),
                      ),
                    )
                        .then((_) {
                      print('on back');
                      model.getData();
                    });*/
                    Navigator.pushNamed(context, RoutePaths.Addplace)
                        .then((value) => model.getData());
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 24, top: 24),
                    child: Text(
                      "+ Add",
                      style: TextStyle(color: PrimaryColor),
                    ),
                  ),
                ),
              ],
            ),
            body: SafeArea(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    MyH1(
                      text: "Favourite",
                    ),
                    UIHelper.verticalSpaceSmall,
                    Expanded(
                      //child: FarPlaceList(key: globalKey),
                      child: model.busy
                          ? Loading()
                          : model.list.length == 0
                              ? Nodata()
                              : ListView.builder(
                                  //shrinkWrap: true,
                                  itemCount: model.list.length,
                                  itemBuilder: (context, index) => FarPlaceItem(
                                    obj: model.list[index],
                                    enable: true,
                                    onPressed: () {
                                      DialogUtils.showCustomDialog(context,
                                          title: "Delete this place?",
                                          okBtnFunction: () {
                                        Navigator.pop(context);
                                        model
                                            .deletePLace(model.list[index])
                                            .then((value) => model.getData());
                                      });
                                    },
                                  ),
                                ),

                    ),
                    UIHelper.verticalSpaceMedium,
                  ],
                ),
              ),
            )));
  }
}
