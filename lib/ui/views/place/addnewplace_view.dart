import 'package:flutter/material.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:mdi/mdi.dart';
import 'package:provider_arc/core/models/placeitemres.dart';
import 'package:provider_arc/core/models/placeobj.dart';
import 'package:provider_arc/core/services/api.dart';
import 'package:provider_arc/ui/shared/app_colors.dart';
import 'package:provider_arc/ui/shared/ui_helpers.dart';
import 'package:provider_arc/ui/widgets/custom/mydialog.dart';
import 'package:provider_arc/ui/widgets/custom/mytext.dart';
import 'package:provider_arc/ui/widgets/item/itemplace.dart';
import 'package:provider_arc/ui/widgets/item/itemradio.dart';
import 'package:provider_arc/ui/widgets/my/mybutton.dart';

import 'addplacemap_view.dart';

class AddNewPlaceView extends StatefulWidget {
  @override
  _AddNewPlaceViewState createState() => _AddNewPlaceViewState();
}

class _AddNewPlaceViewState extends State<AddNewPlaceView> {
  final TextEditingController controllerName = TextEditingController();
  final TextEditingController controllerAddress = new TextEditingController();
  bool invalidName = false;
  bool invalidAddress = false;

  List<Results> places = [];
  final Api _api = new Api();
  var isLoading = false;
  int selecttype = 0;
  List<RadioModel> _listtype = [
    RadioModel(true, "Home", LineAwesomeIcons.home),
    RadioModel(false, "Work", LineAwesomeIcons.briefcase),
    RadioModel(false, "Other", LineAwesomeIcons.map_marker),
  ];

  //Results _selectedplace;
  PlaceObj _farPlaceObj = PlaceObj();

  Future searchPlace() async {
    print("searchPlace....");
    List<Results> list = await _api.searchPlace(controllerAddress.text);
    setState(() {
      places = list;
      isLoading = false;
    });
    print("size:" + places.length.toString());
  }

  _choicetype(int i) {
    debugPrint('choice $i');
    setState(() {
      selecttype = i;
      _listtype[0].isSelected = false;
      _listtype[1].isSelected = false;
      _listtype[2].isSelected = false;
      _listtype[i].isSelected = true;
    });
  }

  void goAddplacemapView(BuildContext context) async {
    var result = await Navigator.push(
        context,
        new MaterialPageRoute(
          builder: (BuildContext context) => new AddPlacemapView(),
        )) as PlaceObj;
    setState(() {
      controllerAddress.text = result.address.toString();
      _farPlaceObj.address = result.address;
      _farPlaceObj.lng = result.lng;
      _farPlaceObj.lat = result.lat;
    });
  }

  _doselect(Results place) {
    setState(() {
      // _selectedplace = place;
      controllerAddress.text = place.formattedAddress.toString();
      places = [];
      _farPlaceObj.address = place.formattedAddress.toString();
      _farPlaceObj.lat = place.geometry.location.lat;
      _farPlaceObj.lng = place.geometry.location.lng;
    });
  }

  @override
  Widget build(BuildContext context) {
    ListView _buildListSearch(context) {
      return ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: places.length,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          // In our case, a DogCard for each doggo.
          return InkWell(
              onTap: () => {
                    //_gotobooking(places[int])
                    _doselect(places[index])
                  },
              child: ItemPlace(places[index]));
        },
      );
    }

    Widget _buildplacetype() {
      return Container(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          RadioItem(
            item: _listtype[0],
            onPressed: () => _choicetype(0),
          ),
          RadioItem(
            item: _listtype[1],
            onPressed: () => _choicetype(1),
          ),
          RadioItem(
            item: _listtype[2],
            onPressed: () => _choicetype(2),
          ),
        ],
      ));
    }

    return Scaffold(
      /*appBar: new AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Add new place',
          style: TitleStyle,
        ),
        leading: new IconButton(
          icon: new Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: <Widget>[
          MaterialButton(
              padding: const EdgeInsets.all(8.0),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              child: Icon(
                Mdi.mapLegend,
                color: PrimaryColor,
              ),
              minWidth: 0,
              height: 40,
              onPressed: () {
                goAddplacemapView(context);
              }),
        ],
      ),*/
      appBar: new AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: new IconButton(
          icon: new Icon(
            Icons.arrow_back,
            color: Dark,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        /* actions: [
          GestureDetector(
            onTap: () {
              Navigator.of(context)
                  .push(
                MaterialPageRoute(
                  builder: (context) => AddplaceView(),
                ),
              )
                  .then((_) {
                print('on back');
              });
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 24, top: 24),
              child: Text(
                "+ Add",
                style: TextStyle(color: PrimaryColor),
              ),
            ),
          ),
        ],*/
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              MyH1(
                text: "Add new place",
              ),
              UIHelper.verticalSpaceSmall,
              UIHelper.verticalSpaceMedium,
              Text('Place type'),
              UIHelper.verticalSpaceSmall,
              _buildplacetype(),
              UIHelper.verticalSpaceMedium,
              Text('Place name'),
              UIHelper.verticalSpaceSmall,
              TextField(
                controller: controllerName,
                decoration: InputDecoration(
                    errorText: invalidName ? 'Value Can\'t Be Empty' : null,
                    suffixIcon: GestureDetector(
                      onTap: () {
                        print("clear");
                        controllerName.clear();
                      },
                      child: Icon(
                        Mdi.closeCircle,
                        color: Colors.black26,
                      ),
                    ),
                    hintText: "Place name",
                    hintStyle: TextStyle(color: Colors.black26),
                    border: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.blueGrey, width: 5.0),
                      borderRadius: BorderRadius.all(Radius.circular(16.0)),
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0)),
              ),
              UIHelper.verticalSpaceMedium,
              Text('Place address'),
              UIHelper.verticalSpaceSmall,
              TextField(
                onChanged: (str) {
                  searchPlace();
                },
                controller: controllerAddress,
                decoration: InputDecoration(
                    errorText: invalidAddress ? 'Value Can\'t Be Empty' : null,
                    suffixIcon: GestureDetector(
                      onTap: () {
                        print("clear");
                        controllerAddress.clear();
                      },
                      child: Icon(
                        Mdi.closeCircle,
                        color: Colors.black26,
                      ),
                    ),
                    hintText: "Place address",
                    hintStyle: TextStyle(color: Colors.black26),
                    border: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.blueGrey, width: 5.0),
                      borderRadius: BorderRadius.all(Radius.circular(16.0)),
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0)),
              ),
              isLoading
                  ? Center(child: CircularProgressIndicator())
                  : _buildListSearch(context),
              UIHelper.verticalSpaceMedium,
              MyButton(
                  caption: 'Save this place', fullsize: true, onPressed: save)
            ],
          ),
        ),
      ),
    );
  }

  save() async {
    if (controllerName.text.isEmpty) {
      DialogUtils.showToast("Please input place name");
      return;
    }
    if (controllerAddress.text.isEmpty) {
      DialogUtils.showToast("Please input place address");
      return;
    }
    _farPlaceObj.name = controllerName.text;
    _farPlaceObj.address = controllerAddress.text;
    _farPlaceObj.type = selecttype;

    _api.addPlace(_farPlaceObj);
    Navigator.pop(context);
  }
}
