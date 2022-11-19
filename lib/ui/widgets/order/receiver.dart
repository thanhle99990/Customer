import 'package:flutter/material.dart';
import 'package:provider_arc/ui/shared/text_styles.dart';

import '../../../core/models/person.dart';

class ReceiverDetail extends StatelessWidget {
  final PersonObj obj;

  const ReceiverDetail({Key key, this.obj}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 1,
      clipBehavior: Clip.antiAlias,
      borderRadius: BorderRadius.circular(8),
      child: Form(
        //key: form,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            AppBar(
              leading: Icon(Icons.verified_user),
              elevation: 0,
              title: Text('Receiver Details'),
              backgroundColor: Theme.of(context).accentColor,
              centerTitle: true,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Name', style: subHeaderStyle),
                  Text(obj.name),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Phone', style: subHeaderStyle),
                  Text(obj.phone),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Address', style: subHeaderStyle),
                  SizedBox(
                    width: 16,
                  ),
                  Expanded(
                      child: Text(
                    obj.address,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  )),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
