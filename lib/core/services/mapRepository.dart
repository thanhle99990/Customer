import 'dart:convert';
import 'dart:core';
import 'dart:math' as Math;

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:http/http.dart' as http;
import 'package:provider_arc/core/constants/app_contstants.dart';
import 'package:provider_arc/core/utils/device_utils.dart';
import 'package:vector_math/vector_math.dart';

class MapRepository {
  static const TAG = "MapRepository";
  GoogleMapsPlaces places = GoogleMapsPlaces(apiKey: KEYS.keyMap);

  Future<String> getRouteCoordinates(LatLng l1, LatLng l2) async {
    String url =
        "https://maps.googleapis.com/maps/api/directions/json?origin=${l1.latitude},${l1.longitude}&destination=${l2.latitude},${l2.longitude}&key=${KEYS.keyDirectionMap}";
    http.Response response = await http.get(url);
    Map values = jsonDecode(response.body);
    Utils.logIt(TAG);
    return values["routes"][0]["overview_polyline"]["points"];
  }

  Future<PlacesAutocompleteResponse> getAutoCompleteResponse(
      String search) async {
    return await places.autocomplete(search, sessionToken: "1212121");
  }

  /* Future<LatLng> getLatLngFromAddress(String address) async {
    List<Placemark> list = await Geolocator().placemarkFromAddress(address);
    return LatLng(list[0].position.latitude, list[0].position.longitude);
  }*/

  LatLng getMidPointBetween(LatLng one, LatLng two) {
    double lat1 = one.latitude;
    double lon1 = one.longitude;
    double lat2 = two.latitude;
    double lon2 = two.longitude;

    double dLon = radians(lon2 - lon1);

    //convert to radians
    lat1 = radians(lat1);
    lat2 = radians(lat2);
    lon1 = radians(lon1);

    // ignore: non_constant_identifier_names
    double Bx = Math.cos(lat2) * Math.cos(dLon);
    // ignore: non_constant_identifier_names
    double By = Math.cos(lat2) * Math.sin(dLon);
    double lat3 = Math.atan2(Math.sin(lat1) + Math.sin(lat2),
        Math.sqrt((Math.cos(lat1) + Bx) * (Math.cos(lat1) + Bx) + By * By));
    double lon3 = lon1 + Math.atan2(By, Math.cos(lat1) + Bx);
    return LatLng(lat3, lon3);
  }
}
