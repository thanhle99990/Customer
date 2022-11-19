import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mdi/mdi.dart';
import 'package:provider_arc/core/constants/app_contstants.dart';
import 'package:provider_arc/core/models/placeitemres.dart';
import 'package:provider_arc/core/models/placeobj.dart';
import 'package:provider_arc/core/services/api.dart';
import 'package:provider_arc/core/utils/pref_helper.dart';
import 'package:provider_arc/ui/shared/app_colors.dart';
import 'package:provider_arc/ui/shared/ui_helpers.dart';
import 'package:provider_arc/ui/widgets/item/itemplace.dart';
import 'package:provider_arc/ui/widgets/my/mybutton.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'addplacemap_view.dart';

class PickAdressView extends StatefulWidget {
  @override
  _PickAdressViewState createState() {
    return _PickAdressViewState();
  }
}

class _PickAdressViewState extends State<PickAdressView> {
  PlaceObj _farPlaceObj = PlaceObj();
  List<Results> places = [];
  List<PlaceObj> _listplaces = [];
  final Api _api = new Api();
  SharedPreferenceHelper _sharedPreferenceHelper = SharedPreferenceHelper();
  final controllerAddress = TextEditingController();
  bool loading = true;
  bool show = false;

  GoogleMapController mapController;
  LatLng _center = const LatLng(10.020909, 105.786489);

  //Position _position;
  final Set<Marker> _markers = {};
  String _addressname = "";

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    updateLocation();
  }

  void initState() {
    super.initState();
    getdata();
  }

  Future<void> getdata() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int userId = prefs.getInt(KEYS.idcustomer);
    List<PlaceObj> _list = await _api.getFarPlace(1);
    setState(() {
      _listplaces = _list;
      loading = false;
    });
  }

  void updateLocation() async {
    try {
      Position newPosition = await Geolocator.getCurrentPosition(
              desiredAccuracy: LocationAccuracy.best)
          .timeout(new Duration(seconds: 20));
      _center = LatLng(newPosition.latitude, newPosition.longitude);
      //click_onmap(_center);
      String place = await _api.findPlaceName(_center);
      setState(() {
        //_position = newPosition;
        _addressname = place;
        _farPlaceObj.address = place;
        _farPlaceObj.lat = newPosition.latitude;
        _farPlaceObj.lng = newPosition.longitude;
      });
      mapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: _center, zoom: 18.0),
        ),
      );
      _markers.add(Marker(
        markerId: MarkerId("1"),
        position: _center,
        icon: BitmapDescriptor.defaultMarker,
        /*icon: BitmapDescriptor.fromBytes(
          await Utils.getBytesFromAsset("assets/icons/location.png", 280),
        ),*/
      ));
    } catch (e) {
      print('Error here ....: ${e.toString()}');
    }
  }

  Future<void> clickOnMap(LatLng latLng) async {
    print('click' + latLng.longitude.toString());
    _center = LatLng(latLng.latitude, latLng.longitude);
    String address = await _api.findPlaceName(_center);
    print('next');
    setState(() {
      _addressname = address;
      _markers.clear();

      _farPlaceObj.address = address;
      _farPlaceObj.lat = latLng.latitude;
      _farPlaceObj.lng = latLng.longitude;
    });
    _markers.add(Marker(
      markerId: MarkerId("1"),
      position: _center,
      icon: BitmapDescriptor.defaultMarker,
      /* icon: BitmapDescriptor.fromBytes(
        await Utils.getBytesFromAsset("assets/icons/location.png", 280),
      ),*/
      infoWindow: InfoWindow(
        title: "$address",
      ),
    ));
    //mapController.showMarkerInfoWindow(MarkerId("1"));
  }

  void finish(PlaceObj obj) {
    setState(() {
      _farPlaceObj = obj;
      controllerAddress.text = _farPlaceObj.address;
    });
    Navigator.pop(context, _farPlaceObj);
  }

  Future searchPlace() async {
    print("searchPlace....");
    List<Results> list = await _api.searchPlace(controllerAddress.text);
    setState(() {
      places = list;
      loading = false;
    });
    print("size:" + places.length.toString());
  }

  ListView _buildListSearch(context) {
    return ListView.builder(
      itemCount: places.length,
      itemBuilder: (context, index) {
        return InkWell(
            onTap: () => {selectSearch(places[index])},
            child: ItemPlace(places[index]));
      },
    );
  }

  ListView _buildListFarplace(context) {
    return ListView.builder(
      itemCount: _listplaces.length,
      itemBuilder: (context, index) {
        return InkWell(
            onTap: () => {selectPlace(_listplaces[index])},
            child: _buildItem(_listplaces[index]));
      },
    );
  }

  Widget _buildItem(PlaceObj obj) {
    return ListTile(
      leading: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
        child: Container(
          padding: EdgeInsets.all(8),
          color: LightGrey,
          child: obj.type == 3
              ? Icon(
                  Mdi.history,
                  color: Colors.white,
                )
              : Icon(
                  Mdi.mapMarker,
                  color: Colors.white,
                ),
        ),
      ),
      title: Text(obj.name),
      subtitle: Text(obj.address),
    );
  }

  void selectSearch(Results place) async {
    int userId = await _sharedPreferenceHelper.userId;
    setState(() {
      places = [];
    });
    PlaceObj obj = PlaceObj(
        address: place.formattedAddress.toString(),
        lat: place.geometry.location.lat,
        lng: place.geometry.location.lng,
        name: place.name,
        type: 3,
        idcustomer: userId);
    _api.addPlace(obj);
    finish(obj);
  }

  void selectPlace(PlaceObj obj) {
    finish(obj);
  }

  void goAddplacemapView(BuildContext context) async {
    var result = await Navigator.push(
        context,
        new MaterialPageRoute(
          builder: (BuildContext context) => new AddPlacemapView(),
        )) as PlaceObj;
    print(result);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: show
            ? Stack(
                children: <Widget>[
                  GoogleMap(
                    myLocationEnabled: true,
                    myLocationButtonEnabled: false,
                    zoomControlsEnabled: false,
                    onMapCreated: _onMapCreated,
                    initialCameraPosition: CameraPosition(
                      target: _center,
                      zoom: 18.0,
                    ),
                    onTap: (LatLng latLng) {
                      clickOnMap(latLng);
                    },
                    markers: _markers,
                  ),
                  Column(
                    children: <Widget>[
                      Container(
                        color: Colors.white,
                        child: ListTile(
                          leading: IconButton(
                            onPressed: () => Navigator.pop(context),
                            icon: Icon(
                              Icons.arrow_back,
                              color: Dark,
                            ),
                          ),
                          title: Text("$_addressname"),
                        ),
                      ),
                      Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(right: 16),
                            child: ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(6.0)),
                              child: Card(
                                child: IconButton(
                                    icon: Icon(
                                      Icons.near_me,
                                      color: Dark,
                                    ),
                                    onPressed: () => {updateLocation()}),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: MyButton(
                          caption: 'Set location',
                          fullsize: true,
                          onPressed: () =>
                              {Navigator.pop(context, _farPlaceObj)},
                        ),
                      )
                    ],
                  )
                ],
              )
            : Stack(
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            MaterialButton(
                              padding: const EdgeInsets.all(8.0),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0)),
                              child: Icon(Icons.clear),
                              //color: Colors.white,
                              textColor: Colors.black,
                              minWidth: 0,
                              height: 40,
                              onPressed: () => Navigator.pop(context),
                            ),
                          ]),
                      TextField(
                        controller: controllerAddress,
                        onChanged: (str) {
                          searchPlace();
                        },
                        decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.location_on,
                              color: PrimaryColor,
                            ),
                            border: InputBorder.none,
                            hintText: "Enter place name",
                            hintStyle: TextStyle(color: Colors.black26),
                            suffixIcon: GestureDetector(
                                onTap: () {
                                  print("clear");
                                  controllerAddress.clear();
                                  setState(() {
                                    places.clear();
                                  });
                                },
                                child: Icon(Icons.clear, color: Colors.grey)),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 16.0)),
                      ),
                      Divider(
                        color: Colors.grey,
                      ),
                      UIHelper.verticalSpaceSmall,
                      GestureDetector(
                        onTap: () => {
                          setState(() {
                            show = true;
                          })
                        },
                        child: ListTile(
                          leading: ClipRRect(
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0)),
                            child: Container(
                              padding: EdgeInsets.all(8),
                              color: LightGrey,
                              child: Icon(
                                Mdi.mapMarker,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          title: Text("Set location on map"),
                        ),
                      ),
                      loading
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : Expanded(child: _buildListFarplace(context)),
                    ],
                  ),
                  places.length == 0
                      ? SizedBox(
                          height: 0,
                        )
                      : Column(
                          children: <Widget>[
                            SizedBox(
                              height: 100,
                            ),
                            Expanded(child: _buildListSearch(context))
                          ],
                        )
                ],
              ),
      ),
    );
  }
}
