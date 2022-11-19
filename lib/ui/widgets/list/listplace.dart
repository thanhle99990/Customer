import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_arc/core/utils/log.dart';
import 'package:provider_arc/core/viewmodels/widgets/placelist.dart';
import 'package:provider_arc/ui/views/base_widget.dart';
import 'package:provider_arc/ui/widgets/custom/mydialog.dart';
import 'package:provider_arc/ui/widgets/item/farplaceitem.dart';
import 'package:provider_arc/ui/widgets/loading.dart';

class FarPlaceList extends StatefulWidget {
  //const FarPlaceList({Key key}) : super(key: key);

  @override
  _FarPlaceListState createState() => _FarPlaceListState();
}
//No use
class _FarPlaceListState extends State<FarPlaceList> {
  @override
  Widget build(BuildContext context) {
    return BaseWidget<PlaceListModel>(
        model: PlaceListModel(api: Provider.of(context)),
        onModelReady: (model) => model.getData(),
        builder: (context, model, child) => model.busy
            ? Loading()
            : ListView.builder(
                shrinkWrap: true,
                itemCount: model.list.length,
                itemBuilder: (context, index) => InkWell(
                  onTap: () {
                    Navigator.pop(context);
                    DialogUtils.showCustomDialog(context,
                        title: "Delete this place?", okBtnFunction: () {
                      model.delPlace(model.list[index]);
                    });
                  },
                  child: FarPlaceItem(
                    obj: model.list[index],
                  ),
                ),
              ));
  }

  void reload() {
    Log.info('reload...');
    Provider.of<PlaceListModel>(context, listen: false).getData();
  }
}
