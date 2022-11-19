import 'package:flutter/material.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:provider_arc/core/viewmodels/views/map_view_model.dart';
import 'package:provider_arc/ui/shared/app_colors.dart';
import 'package:provider_arc/ui/shared/text_styles.dart';
import 'package:provider_arc/ui/shared/ui_helpers.dart';
import 'package:provider_arc/ui/widgets/custom/mybuttonfull.dart';

class Nodriver extends StatelessWidget {
  final MapViewModel model;
  final String message;

  const Nodriver({Key key, this.model, this.message}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        UIHelper.verticalSpaceSmall,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Icon(
              LineAwesomeIcons.exclamation_circle,
              color: Basic,
              size: 48,
            ),
            UIHelper.horizontalSpaceSmall,
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Text("$message", style: BoldStyle.copyWith(color: Basic)),
            )
          ],
        ),
        UIHelper.verticalSpaceSmall,
        MyButtonFull(
          caption: "CLOSE",
          onPressed: () {
            //model.reset();
          },
        )
      ],
    );
  }
}
