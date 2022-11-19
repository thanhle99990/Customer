import 'package:flutter/material.dart';
import 'package:mdi/mdi.dart';
import 'package:provider_arc/core/models/placeitemres.dart';

class ItemPlace extends StatefulWidget {
  final Results placeItemRes;
  ItemPlace(this.placeItemRes);
  @override
  _RowItemBarcodeState createState() => _RowItemBarcodeState();
}

class _RowItemBarcodeState extends State<ItemPlace> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      color: Colors.white,
      child: ListTile(
        // leading: Icon(Mdi.mapMarkerOutline,color: UIData.PrimaryColor),
        title: Text(widget.placeItemRes.name),
        subtitle: Text(widget.placeItemRes.formattedAddress),
        trailing: Icon(Mdi.bookmarkOutline, color: Colors.grey),
      ),
    );
  }

  gobooking() {}
}
