import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:kf_drawer/kf_drawer.dart';
import 'package:provider_arc/core/models/logtripobj.dart';
import 'package:provider_arc/core/viewmodels/views/map_view_model.dart';
import 'package:provider_arc/ui/shared/app_colors.dart';
import 'package:provider_arc/ui/shared/text_styles.dart';
import 'package:provider_arc/ui/shared/ui_helpers.dart';
import 'package:provider_arc/ui/views/base_widget.dart';
import 'package:provider_arc/ui/widgets/fromto2.dart';

// ignore: must_be_immutable
class MyTripView extends KFDrawerContent {
  @override
  _MyTripViewState createState() => _MyTripViewState();
}

class _MyTripViewState extends State<MyTripView>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    _tabController = new TabController(length: 2, vsync: this);
    super.initState();
  }

  Widget buildItem(LogTripObj item) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            item.ngay,
            style: TextStyle(color: Colors.grey),
          ),
          UIHelper.verticalSpaceSmall,
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(16),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 1,
                  offset: Offset(0, 2), // changes position of shadow
                ),
              ],
            ),
            child: Column(
              children: <Widget>[
                FromTo2(
                  from: item.from,
                  to: item.to,
                ),
                Divider(
                  height: 1,
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.circular(48.0),
                        child: Container(
                          height: 40,
                          width: 40,
                          child: CachedNetworkImage(
                            imageUrl: item.profileImage,
                            placeholder: (context, url) =>
                                new CircularProgressIndicator(),
                            errorWidget: (context, url, error) =>
                                new Icon(Icons.error),
                          ),
                        ),
                      ),
                      UIHelper.horizontalSpaceSmall,
                      Column(
                        children: <Widget>[
                          Text(
                            item.name,
                            style: subHeaderStyle,
                          ),
                          RatingBarIndicator(
                            rating: 2.75,
                            itemBuilder: (context, index) => Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            itemCount: 5,
                            itemSize: 50.0,
                            direction: Axis.vertical,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          UIHelper.verticalSpaceSmall
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseWidget<MapViewModel>(
        model: MapViewModel(),
        //onModelReady: (model) => model.getmytrip(),
        builder: (context, model, child) => Scaffold(
            appBar: new AppBar(
              backgroundColor: Colors.white,
              leading: new IconButton(
                icon: new Icon(
                  Icons.arrow_back,
                  //color: Colors.black,
                ),
                onPressed: widget.onMenuPressed,
              ),
              title: new Text("My Trip"),
              bottom: TabBar(
                indicator: UnderlineTabIndicator(
                  borderSide: BorderSide(color: PrimaryColor, width: 2.0),
                  //insets: EdgeInsets.fromLTRB(50.0, 0.0, 50.0, 40.0),
                ),
                unselectedLabelColor: Colors.grey,
                labelColor: PrimaryColor,
                tabs: [
                  new Tab(
                    text: "Complete",
                  ),
                  new Tab(
                    text: "Canceled",
                  ),
                ],
                controller: _tabController,
                indicatorColor: Colors.white,
                indicatorSize: TabBarIndicatorSize.tab,
              ),
              bottomOpacity: 1,
            ),
            body: TabBarView(
              children: [
                /*Container(
                  color: myBackgroundlight,
                  child: ListView.builder(
                    padding: EdgeInsets.all(10.0),
                    itemBuilder: (context, index) =>
                        model.mytrip[index].status == 'cancel'
                            ? Dummy()
                            : buildItem(model.mytrip[index]),
                    itemCount: model.mytrip.length,
                  ),
                ),*/
                /* Container(
                  color: myBackgroundlight,
                  child: ListView.builder(
                    padding: EdgeInsets.all(10.0),
                    itemBuilder: (context, index) =>
                        model.mytrip[index].status == 'cancel'
                            ? buildItem(model.mytrip[index])
                            : Dummy(),
                    itemCount: model.mytrip.length,
                  ),
                ),*/
              ],
              controller: _tabController,
            )));
  }
}
