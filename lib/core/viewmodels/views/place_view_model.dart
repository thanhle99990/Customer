import 'package:provider_arc/core/models/placeobj.dart';
import 'package:provider_arc/core/services/api.dart';
import 'package:provider_arc/core/viewmodels/base_model.dart';

class PlaceViewModel extends BaseModel {
  Api _api = Api();
  List<PlaceObj> _list;

  List<PlaceObj> get list => _list;

  Future getData() async {
    setBusy(true);
    _list = await _api.getFarPlace(1);
    setBusy(false);
  }

  Future deletePLace(PlaceObj obj) async {
    setBusy(true);
    await _api.deletePlace(obj);
    setBusy(false);
  }
}
