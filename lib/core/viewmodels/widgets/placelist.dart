import 'package:meta/meta.dart';
import 'package:provider_arc/core/models/placeobj.dart';
import 'package:provider_arc/core/services/api.dart';

import '../base_model.dart';

class PlaceListModel extends BaseModel {
  Api _api;

  PlaceListModel({
    @required Api api,
  }) : _api = api;

  List<PlaceObj> list;

  Future getData() async {
    setBusy(true);
    list = await _api.getFarPlace(1);
    setBusy(false);
  }

  Future delPlace(PlaceObj obj) async {
    setBusy(true);
    await _api.deletePlace(obj).then((value) => getData());
    setBusy(false);
  }
}
