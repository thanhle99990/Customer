import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart' as poly;
import 'package:flutter_socket_io/flutter_socket_io.dart';
import 'package:flutter_socket_io/socket_io_manager.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:location/location.dart' as location;
import 'package:provider_arc/core/constants/app_contstants.dart';
import 'package:provider_arc/core/constants/enum.dart';
import 'package:provider_arc/core/models/car.dart';
import 'package:provider_arc/core/models/distnattime.dart';
import 'package:provider_arc/core/models/driver.dart';
import 'package:provider_arc/core/models/placeobj.dart';
import 'package:provider_arc/core/models/rating.dart';
import 'package:provider_arc/core/models/response.dart';
import 'package:provider_arc/core/models/ride.dart';
import 'package:provider_arc/core/models/setting.dart';
import 'package:provider_arc/core/models/tbaoobj.dart';
import 'package:provider_arc/core/models/userobj.dart';
import 'package:provider_arc/core/models/vehicle.dart';
import 'package:provider_arc/core/services/api.dart';
import 'package:provider_arc/core/utils/device_utils.dart';
import 'package:provider_arc/core/utils/log.dart';
import 'package:provider_arc/core/utils/pref_helper.dart';
import 'package:provider_arc/core/viewmodels/base_model.dart';
import 'package:provider_arc/ui/shared/app_colors.dart';
import 'package:provider_arc/ui/views/chat/models/user_details.dart';

class MapViewModel extends BaseModel {
  //=================================================================================== <UTILS>
  static const String UTILS = "";
  final mapScreenScaffoldKey = GlobalKey<ScaffoldState>();
  Api api = Api();
  SocketIO _socketIO;
  SharedPreferenceHelper _sharedPreferenceHelper = SharedPreferenceHelper();
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  //Ride
  RideObj _rideObj = RideObj();
  DriverObj _currentDriver;
  UserObj _userObj;
  SettingObj _settingObj;
  List<VehicleObj> _listVehicle = [];
  DistanttimeObj kmTimeToCustomer;

  //int nearestDriverIndex = 0;
  List<DriverObj> _nearDrivers = [];
  CustomerStatus _customerstatus = CustomerStatus.none;
  CarObj _car = CarObj();
  List<LatLng> listLocationDriver = List();
  bool _insideCity = false;

  //=================================================================================== <OBJECTS>
  static const String OBJECTS = "";

  TbaoObj _tbaoObj = TbaoObj(isshow: false, noidung: "");
  String _driverstring = "T??i x??? ??ang t???i";

  //===================================================================================== <MAP>
  static const String MAP = "";
  LatLng _currentPosition; //, _destinationPosition, _pickupPosition;
  double currentZoom = 14;

  final Set<Marker> _markers = Set();
  final Set<Polyline> _polyLines = Set();

  List<Prediction> pickupPredictions = [];

  List<Prediction> destinationPredictions = [];

  GoogleMapController _mapController;

  location.Location _location = location.Location();

  //===================================================================================== <GET_METHODS>
  static const String GET_METHODS = "";

  RideObj get rideobj => _rideObj;

  UserObj get userObj => _userObj;

  SettingObj get settingObj => _settingObj;

  CarObj get car => _car;

  List<VehicleObj> get listVehicle => _listVehicle;

  bool get insideCity => _insideCity;

  CustomerStatus get customerstatus => _customerstatus;

  TbaoObj get tbaoObj => _tbaoObj;

  List<DriverObj> get nearDrivers => _nearDrivers;

  String get driverstring => _driverstring;

  LatLng get currentPosition => _currentPosition;

  GoogleMapController get mapController => _mapController;

  Set<Marker> get markers => _markers;

  Set<Polyline> get polyLines => _polyLines;

  get randomZoom => 13.0 + Random().nextInt(4);

  DriverObj get currentDriver => _currentDriver;

  //===================================================================================== <METHODS>
  static const String METHODS = "";

  bool _disposed = false;

  Timer _timer;

  @override
  void dispose() {
    _disposed = true;
    _timer.cancel();
    super.dispose();
  }

  void startTimer() {
    const oneSec = const Duration(seconds: 60);
    _timer = new Timer.periodic(
        oneSec,
            (Timer timer) => {
          if (customerstatus == CustomerStatus.none)
            {
              backNone(),
              getNearbyDriver(),
            }
        });
  }

  @override
  void notifyListeners() {
    if (!_disposed) {
      super.notifyListeners();
    }
  }

  /// Default Constructor
  init() {
    setBusy(true);
    getInitData();//get Data ban ?????u, list vehicle v?? setting
    getUserData();//get data c???a customer
    getUserLocation();//l???y ??c v??? tr?? thi???t b??? v?? c???p nh???t kinh ????? v?? ????? m???i l??n dtb c???a account, hi???n th??? marker c???a customer l??n b???n ?????
    getNearbyDriver();// l???y list driver v?? hi???n th??? tr??n b???n ?????, c??n ??? g???n th?? ch??a l??m
    initSocketio(); // k???t n???i v???i socket v?? c???p nh???t lu??n t??nh tr???ng online/offline c???a t??i x???
    initFcm(); // c???u h??nh firebaseMessaging v?? update token m???i cho user
    //new
    startTimer();

    setBusy(false);
  }

  Future<void> getInitData() async { // get data ban ?????u, list vehicle v?? setting
    _listVehicle = await api.getvehicle();// l???y list vehicle
    _settingObj = await api.getSetting();// l???y setting
    Log.obj(_settingObj);// in debug v???i Object b??? m?? h??a th??nh JSON
    notifyListeners();
  }

  Future<void> getUserData() async { //get data c???a customer
    ResponseObj responseObj = await api.getUserDetail();// ResponseObj g???m code, message, data
    if (responseObj.code == 0) {// code = 0 successfully
      _userObj = UserObj.fromJson(responseObj.data);// l???y data c???a ResponseObj g??n v??o UserObj
      addDataToDb(_userObj);
      print('idride ${_userObj.idride}');
      if (_userObj.idride != 0) {// n???u idride = 0
        _rideObj = await api.getRide(_userObj.idride);//l???y chuy???n ??i c???a user v?? g??n cho rideObj
        CustomerStatus customerStatus =
        EnumToString.fromString(CustomerStatus.values, _rideObj.status);
        _currentDriver = await api.getDriverDetail(_rideObj.iddriver);//g??n t??i x??? v?? _currentDriver
        _car = await api.getCar(currentDriver.iddriver);//g??n Car c???a t??i x??? v?? _car
        setStatus(customerStatus);
      }
    }
    notifyListeners();
  }

  ///#0
  void getUserLocation() async { //l???y ??c v??? tr?? thi???t b??? v?? c???p nh???t kinh ????? v?? ????? m???i l??n dtb c???a account, hi???n th??? marker c???a customer l??n b???n ?????
    _markers.clear();// clear h???t markers trong Set
    _location.getLocation().then((data) async {//l???y v??? tr?? c???a thi???t b??? l??u v??o data
      _currentPosition = LatLng(data.latitude, data.longitude);//g??n v??? tr?? thi???t b??? cho currentPosition
      String city = await api.findCity(_currentPosition);// l???y ??c t??n th??nh ph??? d???a tr??n kinh ????? v?? v?? ????? v?? g??n cho city
      print('coty: $city');
      String address = await api.findPlaceName(_currentPosition);// l???y ??c ?????a ch??? t??? kinh ????? v?? ????? v?? g??n cho address
      _rideObj.from = address;// from b???ng ?????a ch??? l??c ?????u
      _rideObj.fromlat = _currentPosition.latitude;//v?? ?????
      _rideObj.fromlng = _currentPosition.longitude;//kinh ?????
      UserObj newUser = UserObj();
      newUser.latitude = _currentPosition.latitude;
      newUser.longitude = _currentPosition.longitude;
      api.updateProfile(newUser);//update th??ng tin user n??y, ??? ????y l?? update v??? tr?? customer l??n dtb
      addMarker(
          _currentPosition, Constants.currentLocationMarkerId, CMarker.pickup);// add marker c???a customer l??n b???n ?????
      notifyListeners();
    });
  }

  /// when map is created
  void onMapCreated(GoogleMapController controller) {//t???o map v?? hi???n tr??? marker c???a customer
    _mapController = controller;
    _location.changeSettings(interval: 15000, distanceFilter: 0.01);
    _location.onLocationChanged().listen((event) async {
      try {
        _currentPosition = LatLng(event.latitude, event.longitude);
        removeMarker(Constants.currentLocationMarkerId);
        addMarker(_currentPosition, Constants.currentLocationMarkerId,
            CMarker.pickup);
        //
        CameraPosition cPosition = CameraPosition(
          zoom: currentZoom,
          //tilt: CAMERA_TILT,
          //bearing: CAMERA_BEARING,
          target: LatLng(_currentPosition.latitude, _currentPosition.longitude),
        );
        if (_customerstatus == CustomerStatus.gotopickup ||
            _customerstatus == CustomerStatus.arrived) {
          _mapController
              .animateCamera(CameraUpdate.newCameraPosition(cPosition));
        }
      } on Exception catch (_) {
        //print('error on update location');
      }
    });
    notifyListeners();
  }

  void getNearbyDriver() async { // l???y danh s??ch t??i x??? ??? g???n customer ????
    _nearDrivers = await api.getNearbyDriver();
    LatLng point;
    _nearDrivers.forEach((item) => {
      if (item.longitude != null)
        {
          point = LatLng(item.latitude, item.longitude),
          addMarker(point, item.iddriver.toString(), CMarker.driver)// ch???y t???ng c??i driver trong ph???m vi v?? hi???n th??? marker driver l??n b???n ?????
        }
    });
    notifyListeners();
    print('nearby driver size: ${_nearDrivers.length}');// s??? l?????ng t??i x??? ??? g???n
  }

  Future<List<DriverObj>> getAvailableDriver(int sex, int accept) async {
    List<DriverObj> list = await api.getAvailableDriver(sex, accept);
    notifyListeners();
    print('AVAILABLE DRIVER size: ${list.length}');
    return list;
  }

  void removeAllDriverMarker() async {
    _nearDrivers.forEach((item) => {removeMarker(item.iddriver.toString())});
  }

  ///#1
  Future<void> selectDestination(PlaceObj fromplace, PlaceObj toplace) async {
    getInitData();

    if (fromplace != null) {
      _rideObj.from = fromplace.address;
      _rideObj.fromlat = fromplace.lat;
      _rideObj.fromlng = fromplace.lng;
      api.addPlace(fromplace);
      _markers.clear();
      LatLng pick = LatLng(fromplace.lat, fromplace.lng);
      addMarker(pick, Constants.pickupMarkerId, CMarker.pickup);
    }
    LatLng pick = LatLng(_rideObj.fromlat, _rideObj.fromlng);
    mapController.animateCamera(
        CameraUpdate.newLatLngZoom(pick, 15.0 + Random().nextInt(4)));

    _rideObj.to = toplace.address;
    _rideObj.tolat = toplace.lat;
    _rideObj.tolng = toplace.lng;
    _rideObj.payment = 0;

    api.addPlace(toplace);

    LatLng des = LatLng(toplace.lat, toplace.lng);
    addMarker(des, Constants.destinationMarkerId, CMarker.destination);
    await getNearbyDriver();
    createCurrentRoute();
    await findDistantDuration();

    //update Value
    _settingObj = await api.getSetting();
    Log.obj(_settingObj);
    for (var vehicle in _listVehicle) {
      vehicle.price =
      (vehicle.cost * _rideObj.km / 1000 + _settingObj.initrace);
      Log.info('price: ${vehicle.price}');
      double discount = _settingObj.discount * vehicle.price / 100;
      Log.info('discount: $discount');
      vehicle.price = vehicle.price - discount;
      //Log.info(vehicle.price.toString());
    }

    setStatus(CustomerStatus.book);
    notifyListeners();
  }

  void createRoute(LatLng point1, LatLng point2) async {//v??? ???????ng
    _polyLines.clear();
    List<LatLng> list = List();
    poly.PolylinePoints polylinePoints = poly.PolylinePoints();
    poly.PointLatLng from = poly.PointLatLng(point1.latitude, point1.longitude);
    poly.PointLatLng to = poly.PointLatLng(point2.latitude, point2.longitude);

    poly.PolylineResult result = await polylinePoints
        .getRouteBetweenCoordinates(KEYS.keyDirectionMap, from, to,
        travelMode: poly.TravelMode.transit);
    if (result.points.isNotEmpty) {
      result.points.forEach((poly.PointLatLng point) {
        list.add(LatLng(point.latitude, point.longitude));
      });
    }
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(
        polylineId: id,
        patterns: <PatternItem>[],
        color: PrimaryColor,
        points: list,
        width: 3,
        onTap: () {});
    _polyLines.add(polyline);
    notifyListeners();
  }

  ///Creating a Route
  void createCurrentRoute() async {
    List<LatLng> list = List();
    poly.PolylinePoints polylinePoints = poly.PolylinePoints();
    poly.PointLatLng from =
    poly.PointLatLng(_rideObj.fromlat, _rideObj.fromlng);
    poly.PointLatLng to = poly.PointLatLng(_rideObj.tolat, _rideObj.tolng);
    poly.PolylineResult result = await polylinePoints
        .getRouteBetweenCoordinates(KEYS.keyDirectionMap, from, to,
        travelMode: poly.TravelMode.transit);
    if (result.points.isNotEmpty) {
      result.points.forEach((poly.PointLatLng point) {
        list.add(LatLng(point.latitude, point.longitude));
      });
    }
    PolylineId id = PolylineId(Constants.currentRoutePolylineId);
    Polyline polyline = Polyline(
        polylineId: id,
        patterns: <PatternItem>[],
        color: SecondaryColor,
        points: list,
        width: 5,
        onTap: () {});
    _polyLines.add(polyline);
    notifyListeners();
  }

  void createRouteTaxi() async {
    PolylineId id = PolylineId(Constants.driverRoutePolylineId);
    Polyline polyline = Polyline(
        polylineId: id,
        patterns: <PatternItem>[],
        color: Colors.yellow,
        points: listLocationDriver,
        width: 6,
        onTap: () {});
    _polyLines.add(polyline);
    notifyListeners();
  }

  void findDistantDuration() async {
    LatLng _from = LatLng(_rideObj.fromlat, _rideObj.fromlng);
    LatLng _to = LatLng(_rideObj.tolat, _rideObj.tolng);
    if (_from == null) return;
    if (_to == null) return;
    DistanttimeObj distanttimeObj = await api.getDistantTime(_from, _to);
    //print(json.encode(distanttimeObj));
    var status = distanttimeObj.rows[0].elements[0].status;
    if (status == 'ZERO_RESULTS') {
      _tbaoObj.isshow = true;
      _tbaoObj.noidung = "Invalid From-to address";
      _rideObj.to = null;
    } else {
      _rideObj.kmtext = distanttimeObj.rows[0].elements[0].distance.text;
      _rideObj.timetext = distanttimeObj.rows[0].elements[0].duration.text;

      _rideObj.km = distanttimeObj.rows[0].elements[0].distance.value;
      _rideObj.time = distanttimeObj.rows[0].elements[0].duration.value;
    }

    notifyListeners();
  }

  /// listening to camera moving event
  void onCameraMove(CameraPosition position) {
    currentZoom = position.zoom;
    notifyListeners();
  }

  void randomMapZoom() {
    mapController
        .animateCamera(CameraUpdate.zoomTo(15.0 + Random().nextInt(5)));
  }

  void onMyLocationFabClicked() { // sau khi b???m bi???u t?????ng v??? tr?? th?? map s??? tr??? l???i v??? tr?? c???a user
    mapController.animateCamera(CameraUpdate.newLatLngZoom(
        currentPosition, 15.0 + Random().nextInt(4)));
    if (customerstatus == CustomerStatus.none) {
      _markers.clear();
      getNearbyDriver();
      getUserLocation();
      addMarker(
          _currentPosition, Constants.currentLocationMarkerId, CMarker.pickup);
    }
  }

  void panelIsClosed() {
    onMyLocationFabClicked();
  }

  void setStatus(CustomerStatus value) {
    _customerstatus = value;
    notifyListeners();
  }

  void addMarker(LatLng location, String id, CMarker cMarker) async { //addmarker
    String icon;
    int size = 150;
    switch (cMarker) {
      case CMarker.pickup:
        icon = "assets/icons/pick.png";
        break;
      case CMarker.destination:
        icon = "assets/icons/des.png";
        size = 100;
        break;
      case CMarker.driver:
        icon = "assets/icons/iconcar.png";
        break;
      case CMarker.currdriver:
        icon = "assets/icons/iconcar.png";
        break;
    }
    if (location == null) return;
    _markers.add(Marker(
        markerId: MarkerId(id),
        position: location,
        draggable: true,
        anchor: Offset(0.5, 0.5),
        icon: BitmapDescriptor.fromBytes(
            await Utils.getBytesFromAsset(icon, size))));
    notifyListeners();
  }

  void removeMarker(String myId) {
    _markers.removeWhere((m) => m.markerId.value == myId);
    notifyListeners();
  }

  //=================================================================================== <DOING>
  static const String DOING = "";

  Future<void> selectCar(VehicleObj car) async { //ch???n xe
    SettingObj settingObj = await api.getSetting();
    //double price = (car.cost * rideobj.km / 1000) + settingObj.initrace;
    _rideObj.price = car.price;
    _rideObj.vehicle = car.typename;
    //_rideObj.accept = car.idvehicle;
    notifyListeners();
  }

  //#2
  Future<bool> preBook(int accept) async { // t??m ra t??i x??? available v?? g???n nh???t
    _settingObj = await api.getSetting();
    //List<DriverObj> list = await getAvailableDriver(_userObj.sex, _rideObj.accept); //phuong tien gi?
    List<DriverObj> list = await getAvailableDriver(_userObj.sex,accept); // list ra danh s??ch t??i x??? c?? s???n
    //List<DriverObj> list = await getAvailableDriver(_userObj.sex, _rideObj.vehicle);
    _currentDriver = await Utils.findNearestDriver( // t??m ra t??i x??? g???n nh???t
        list, _currentPosition, _settingObj.maxkm);
    print('find _currentDriver:' + json.encode(_currentDriver));
    notifyListeners();
    if (_currentDriver == null) {
      return false;
    } else {
      return true;
    }
  }

  void book() async {
    setBusy(true);
    ResponseObj responseObj =
    await api.addRide(_rideObj, currentDriver.iddriver);
    if (responseObj.code == 0) {
      _rideObj.idride = responseObj.data;
    }
    sendMessage('request', currentDriver.iddriver, _rideObj.idride, null); // send Message to socket IO
    sendFcm(currentDriver.token, "New request from customer"); // send FCM to Driver

    setStatus(CustomerStatus.waiting); // chuy???n sang state Waiting
    notifyListeners();
    setBusy(false);
  }

  void backNone() {
    justWait(numberOfSeconds: 3);
    _customerstatus = CustomerStatus.none;
    _rideObj.to = null;
    _rideObj.idride = null;
    _currentDriver = null;
    _polyLines.clear();
    _markers.clear();
    removeMarker(Constants.destinationMarkerId);
    removeMarker(Constants.driverMarkerId);
    getUserLocation();
    notifyListeners();
  }

  void cancelBooking() {
    backNone();
    if (currentDriver != null) {
      sendMessage('cancel', currentDriver.iddriver, _rideObj.idride, null);
      sendFcm(currentDriver.token, "Customer has cancel trip");
    }
    api.updateRide(_rideObj, CustomerStatus.cancel); // set status = cancel
    notifyListeners();
  }

  void cancelRide() { // send Message to socketio and send FCM to driver
    sendMessage('cancel', currentDriver.iddriver, _rideObj.idride, null);
    sendFcm(currentDriver.token, "Customer has cancel trip");
    api.updateRide(_rideObj, CustomerStatus.cancel); //

    backNone();
    notifyListeners();
  }

  Future<void> accept() async {
    createRouteTaxi();
    addMarker(LatLng(currentDriver.latitude, currentDriver.longitude),
        Constants.driverMarkerId, CMarker.driver);
    setStatus(CustomerStatus.gotopickup);
    //LatLng point = LatLng(currentDriver.latitude, currentDriver.longitude);
    kmTimeToCustomer = await api.getDistantTime(_currentPosition, LatLng(_currentDriver.latitude, _currentDriver.longitude));
    Log.obj(kmTimeToCustomer);
    notifyListeners();
  }

  void cancelConfirm() {
    setStatus(CustomerStatus.cancel);
    notifyListeners();
  }

  void cancelNo() {
    setStatus(CustomerStatus.gotopickup);
    notifyListeners();
  }

  void rating() {
    setStatus(CustomerStatus.rating);
    notifyListeners();
  }

  void submitRating(RatingObj obj) {
    api.addRating(obj);
    backNone();
    notifyListeners();
  }

  void hideNote() async {
    _tbaoObj.isshow = false;
    notifyListeners();
  }

  void showNote() async {
    _tbaoObj.isshow = true;
    notifyListeners();
  }

  void setPayment(int i) async { //set Payment
    _rideObj.payment = i;
    notifyListeners();
  }

  void confirmMail(String email) async {
    api.mail(email, "");
    notifyListeners();
  }

  //=================================================================================== <COMUNICATE>
  static const String COMUNICATE = "";

  void sendFcm(String token, String message) {
    api.sendFcm(token, message);
  }

  initSocketio() async {
    int chatID = await _sharedPreferenceHelper.userId;
    //String chatID = gen4Card();
    try {
      SocketIOManager().destroyAllSocket();
    } on Exception catch (_) {
      print("throwing new error");
      throw Exception("Error on server");
    }
    _socketIO = SocketIOManager()
        .createSocketIO(KEYS.socketIo, '/', query: 'chatID=$chatID');//update your domain before using
    _socketIO.init(); //call init socket before doing anything
    _socketIO.subscribe('receive_message', (jsonData) {//Subscribe to a channel with a callback
      //print("jsonData:" + json.encode(jsonData));
      messageOn(jsonData);
    });
    _socketIO.subscribe('receive_all', (jsonData) {//Subscribe to a channel with a callback
      messageOnAll(jsonData);
    });
    _socketIO.connect();//connect socket
  }

  void sendMessage( // send message to socket IO
      String content, int receiverChatID, int value, String text) async {
    int chatID = await _sharedPreferenceHelper.userId;
    _socketIO.sendMessage(
      'send_message',
      json.encode({
        'receiverChatID': receiverChatID.toString(),
        'senderChatID': chatID,
        'content': content,
        'value': value,
        'text': text,
      }),
    );
  }

  void messageOn(String jsonData) {//nh???n message
    print("messageOn:" + json.encode(jsonData));
    Map<String, dynamic> data = json.decode(jsonData);
    String content = data['content'];
    int senderChatID = data['senderChatID'];
    int value = data['value'];
    String text = data['text'];
    processContent(senderChatID, content, value, text);
  }

  void messageOnAll(String jsonData) {
    print("messageOnAll:" + json.encode(jsonData));
    Map<String, dynamic> data = json.decode(jsonData);
    String content = data['content'];
    int senderChatID = data['senderChatID'];
    int value = data['value'];
    String text = data['text'];
    processContent(senderChatID, content, value, text);
  }

  Future<void> processContent(
      int senderChatID, String content, int value, String text) async {
    if (content == 'offline') {//n???u offline th?? x??a markerc c???a driver tr??n b???ng ?????
      removeMarker(senderChatID.toString());
      /* if (_customerstatus == CustomerStatus.none){
        _markers.clear();
        getUserLocation();
        getNearbyDriver();
      }  */
    } else if (content == 'online') {//add marker c???a t??i x??? l???i
      DriverObj driver = await api.getDriverDetail(senderChatID);
      LatLng point = LatLng(driver.latitude, driver.longitude);
      addMarker(point, driver.iddriver.toString(), CMarker.driver);
      /*if (_customerstatus == CustomerStatus.none){
        _markers.clear();
        getUserLocation();
        getNearbyDriver();
      }*/
    } else if (content == 'reject') {
      backNone();//v??? l???i trang none
      notifyListeners();
    } else if (content == 'cancel') {
      backNone();//v??? l???i trang none
      notifyListeners();
    } else if (content == 'accept') {
      _driverstring = "T??i x??? ??ang chu???n b??? t???i";
      _car = await api.getCar(currentDriver.iddriver);
      _markers.clear();//clear marker l???n n???a

      addMarker(LatLng(_rideObj.fromlat, _rideObj.fromlng),
          Constants.currentLocationMarkerId, CMarker.pickup); //add marker cho customer ch??? ????n
      addMarker(LatLng(_rideObj.tolat, _rideObj.tolng),
          Constants.destinationMarkerId, CMarker.destination); //add marker cho ch??? ?????a ??i???m ?????n
      addMarker(LatLng(currentDriver.latitude, currentDriver.longitude),
          Constants.driverMarkerId, CMarker.currdriver); //add marker cho driver
      //_polyLines.clear();
      LatLng driver = LatLng(currentDriver.latitude, currentDriver.longitude);
      createRoute(driver, _currentPosition); // v??? ???????ng cho t??i x??? t???i ch??? ??i???m ????n
      _customerstatus = CustomerStatus.gotopickup; // ?????i tr???ng th??i c???a customer th??nh gotopickup v?? chuy???n sang state accept
      kmTimeToCustomer = await api.getDistantTime(_currentPosition,
          LatLng(_currentDriver.latitude, _currentDriver.longitude)); //g??n qu??ng ???????ng v?? th???i gian cho bi???n
      Log.obj(kmTimeToCustomer);
      notifyListeners();
    } else if (content == 'arrived') {
      _customerstatus = CustomerStatus.arrived;
      _driverstring = "T??i x??? ??ang t???i";
      notifyListeners();
    } else if (content == 'beginride') {
      _polyLines.clear();
      removeMarker(Constants.pickupMarkerId);
      removeMarker(Constants.currentLocationMarkerId);
      LatLng driver = LatLng(currentDriver.latitude, currentDriver.longitude);
      LatLng des = LatLng(_rideObj.tolat, _rideObj.tolng);
      createRoute(driver, des); // t???o ???????ng ??i t??? v??? tr?? driver t???i ??i???m ?????n

      _customerstatus = CustomerStatus.beginride;
      _driverstring = "RIDE START";
      notifyListeners();
    } else if (content == 'complete') {
      _customerstatus = CustomerStatus.rating;
      notifyListeners();
    } else if (content == 'location') {
      Map<String, dynamic> d = json.decode(text);
      PlaceObj place = PlaceObj.fromJson(d);
      LatLng driver = LatLng(place.lat, place.lng);
      removeMarker(Constants.driverMarkerId);
      //addMarker(point, Constants.driverMarkerId, CMarker.currdriver);
      //createRoute(driver, _currentPosition);
      _markers.add(Marker(
          markerId: MarkerId(Constants.driverMarkerId),
          position: driver,
          draggable: true,
          rotation: place.heading - 78,
          flat: true,
          anchor: Offset(0.5, 0.5),
          icon: BitmapDescriptor.fromBytes(
              await Utils.getBytesFromAsset("assets/icons/iconcar.png", 100))));
      notifyListeners();
    }
  }

  initFcm() {
    var initializationSettingsAndroid =
    new AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettingsIOS = new IOSInitializationSettings(
        onDidReceiveLocalNotification: onDidRecieveLocalNotification);
    var initializationSettings = new InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification); // B?????c ?????u ti??n l?? t???o m???t phi??n b???n m???i c???a l???p plugin v?? sau ???? kh???i t???o n?? v???i c??c c??i ?????t ????? s??? d???ng cho t???ng n???n t???ng
    _firebaseMessaging.configure(
      // ignore: missing_return
      onMessage: (Map<String, dynamic> message) {
        print('on message $message');
        displayNotification(message); // hi???n th??? th??ng b??o
      },
      // ignore: missing_return
      onResume: (Map<String, dynamic> message) {
        print('on resume $message');
      },
      // ignore: missing_return
      onLaunch: (Map<String, dynamic> message) {
        print('on launch $message');
      },
    );
    _firebaseMessaging.requestNotificationPermissions( // xin quy???n cho ph??p g???i tin nh???n
        const IosNotificationSettings(sound: true, badge: true, alert: true));
    _firebaseMessaging.onIosSettingsRegistered // li??n quan t???i ios
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });
    _firebaseMessaging.getToken().then((String token) {
      assert(token != null); // n???u token b???ng null th?? gi??n ??o???n qu?? tr??nh th???c thi
      Log.info(token);
      UserObj newUser = UserObj();
      newUser.token = token;
      api.updateProfile(newUser); // update token m???i cho user
    });
  }

  Future displayNotification(Map<String, dynamic> message) async { // hi???n th??? th??ng b??o
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
        'channelid', 'flutterfcm', 'your channel description',
        importance: Importance.Max, priority: Priority.High);
    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
    var platformChannelSpecifics = new NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      message['notification']['title'],
      message['notification']['body'],
      platformChannelSpecifics,
      payload: 'hello',
    );
  }

  Future onSelectNotification(String payload) async {
    if (payload != null) {
      debugPrint('notification payload: ' + payload);
    }
  }

  Future onDidRecieveLocalNotification(
      int id, String title, String body, String payload) async {}

  void addDataToDb(UserObj user) {
    DocumentReference _documentReference;
    UserDetails _userDetails = UserDetails();
    var mapData = Map<String, String>();// hai string g???m t??n c???t v?? gi?? tr??? c???t
    String uid;
    _userDetails.name = user.name;
    _userDetails.emailId = user.email;
    _userDetails.photoUrl = user.profile;
    _userDetails.uid = user.idcustomer.toString();
    _userDetails.phone = user.phone;
    mapData = _userDetails.toMap(_userDetails);

    uid = user.idcustomer.toString();

    _documentReference = Firestore.instance.collection("users").document(uid);

    _documentReference.get().then((documentSnapshot) {
      if (documentSnapshot.exists) {
        Log.info('exists user on firestore');
      } else {
        _documentReference.setData(mapData).whenComplete(() {
          Log.info("Users Colelction added to Database");
          /* Navigator.pushReplacement(context,
              new MaterialPageRoute(builder: (context) => AllUsersScreen()));*/
        }).catchError((e) {
          print("Error adding collection to Database $e");
        });
      }
    });
  }

  void justWait({@required int numberOfSeconds}) async {
    await Future.delayed(Duration(seconds: numberOfSeconds));
  }
}
