import 'package:provider_arc/core/models/placeobj.dart';
import 'package:provider_arc/core/services/api.dart';
import 'package:provider_arc/core/viewmodels/base_model.dart';

class FromToViewModel extends BaseModel {
  Api _api = Api();
  List<PlaceObj> list1;// list Favorite Place đc thêm từ trc
  List<PlaceObj> list0;// list Place đi gần đây

  Future getData() async {// hiện gợi ý place
    setBusy(true);
    list1 = await _api.getFarPlace(1);// lấy list Favorite Place đc thêm từ trc
    list0 = await _api.getFarPlace(0);// lấy list Place đi gần đây
    setBusy(false);
  }

  Future deletePLace(PlaceObj obj) async {// xóa place
    setBusy(true);
    await _api.deletePlace(obj);//xóa Place
    setBusy(false);
  }

}
