import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider_arc/core/models/placeitemres.dart';
import 'package:provider_arc/core/models/placeobj.dart';
import 'package:provider_arc/core/services/api.dart';
import 'package:provider_arc/ui/shared/app_colors.dart';
import 'package:provider_arc/ui/widgets/item/itemplace.dart';
import 'package:provider_arc/ui/widgets/my/mybutton.dart';

//no use
class AddPlacemapView extends StatefulWidget {
  @override
  _AddPLacemapViewState createState() => _AddPLacemapViewState();
}

class _AddPLacemapViewState extends State<AddPlacemapView> {
  GoogleMapController mapController;
  final controllerAddress = TextEditingController();
  LatLng _center = const LatLng(10.020909, 105.786489);
  final Set<Marker> _markers = {};
  PlaceObj _farPlaceObj = PlaceObj();
  bool onsearch = false;
  List<Results> places = [];
  String placename = '';
  Api _api = Api();

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  void initState() {
    super.initState();
    updateLocation();
  }

  void updateLocation() async {
    try {
      Position newPosition = await Geolocator.getCurrentPosition(
              desiredAccuracy: LocationAccuracy.best)
          .timeout(new Duration(seconds: 20));
      _center = LatLng(newPosition.latitude, newPosition.longitude);
      String place = await _api.findPlaceName(_center);
      setState(() {
        //_position = newPosition;
        _center = LatLng(newPosition.latitude, newPosition.longitude);
        _markers.add(Marker(
          markerId: MarkerId(_center.toString()),
          position: _center,
          icon: BitmapDescriptor.defaultMarker,
        ));
        placename = place;
        _farPlaceObj.address = place;
        _farPlaceObj.lat = newPosition.latitude;
        _farPlaceObj.lng = newPosition.longitude;
      });
      mapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: _center, zoom: 18.0),
        ),
      );
    } catch (e) {
      print('Error here ....: ${e.toString()}');
    }
  }

  Future searchPlace() async {
    print("searchPlace....");
    List<Results> list = await _api.searchPlace(controllerAddress.text);
    setState(() {
      places = list;
    });
    print("size:" + places.length.toString());
  }

  selectSearch(Results place) async {
    setState(() {
      placename = place.formattedAddress.toString();
      places = [];
      onsearch = false;
      _center =
          LatLng(place.geometry.location.lat, place.geometry.location.lng);
      _farPlaceObj.address = placename;
    });
    _markers.clear();
    _markers.add(Marker(
      markerId: MarkerId(_center.toString()),
      position: _center,
      icon: BitmapDescriptor.defaultMarker,
    ));
    mapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: _center, zoom: 18.0),
      ),
    );
  }

  Future<void> _clickopmap(LatLng latLng) async {
    print('click' + latLng.longitude.toString());
    _center = LatLng(latLng.latitude, latLng.longitude);
    String place = await _api.findPlaceName(_center);
    setState(() {
      _markers.clear();
      _markers.add(Marker(
        markerId: MarkerId(_center.toString()),
        position: _center,
        icon: BitmapDescriptor.defaultMarker,
      ));
      placename = place;
      _farPlaceObj.address = place;
      _farPlaceObj.lat = latLng.latitude;
      _farPlaceObj.lng = latLng.longitude;
    });
  }

  @override
  Widget build(BuildContext context) {
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

    return Scaffold(
      appBar: new AppBar(
        title: new Text(
          placename,
          style: TextStyle(color: Colors.black, fontSize: 12),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: new IconButton(
          icon: new Icon(
            Icons.arrow_back_ios,
            color: PrimaryColor,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: <Widget>[
          IconButton(
            icon: new Icon(
              Icons.search,
              color: Colors.black,
            ),
            onPressed: () {
              setState(() {
                onsearch = true;
              });
            },
          ),
        ],
      ),
      body: Stack(
        children: <Widget>[
          GoogleMap(
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: _center,
              zoom: 18.0,
            ),
            onTap: (LatLng latLng) {
              _clickopmap(latLng);
            },
            markers: _markers,
          ),
          Column(
            children: <Widget>[
              onsearch
                  ? Container(
                      color: Colors.white,
                      child: Column(
                        children: <Widget>[
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
                                    },
                                    child:
                                        Icon(Icons.clear, color: Colors.grey)),
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 16.0)),
                          ),
                        ],
                      ),
                    )
                  : SizedBox(
                      height: 0,
                    ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: MyButton(
                  caption: 'Set Location',
                  fullsize: true,
                  onPressed: () => {Navigator.pop(context, _farPlaceObj)},
                ),
              )
            ],
          ),
          places.length == 0
              ? SizedBox(
                  height: 0,
                )
              : Column(
                  children: <Widget>[
                    SizedBox(
                      height: 50,
                    ),
                    Expanded(child: _buildListSearch(context))
                  ],
                )
        ],
      ),
    );
  }
}
