import 'package:avatar_glow/avatar_glow.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:provider_arc/core/utils/device_utils.dart';
import 'package:provider_arc/core/viewmodels/views/map_view_model.dart';
import 'package:provider_arc/ui/shared/app_colors.dart';
import 'package:provider_arc/ui/shared/ui_helpers.dart';
import 'package:provider_arc/ui/widgets/my/avatar.dart';
import 'package:slider_button/slider_button.dart';

class Waiting extends StatelessWidget {
  final MapViewModel model;

  const Waiting({Key key, this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      color: Colors.black.withOpacity(0.3),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Center(
                child: AvatarGlow(
                  endRadius: 200.0,
                  glowColor: PrimaryColor,
                  child: MyAvatarC(
                    size: DeviceUtils.getScaledWidth(context, 1/10),
                    url: 'assets/icons/icon.png',
                  ),
                ),
              ),
            ),
            UIHelper.verticalSpaceLarge,
            Center(
                child: SliderButton(
              vibrationFlag: false,
              action: () {
                print('action');
                model.cancelRide(); // trượt để hủy chuyến
              },
              label: Text(
                "Slide to cancel",
                style: TextStyle(
                    color: Color(0xff4a4a4a),
                    fontWeight: FontWeight.w500,
                    fontSize: 17),
              ),
              icon: Text(
                "",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 32,
                ),
              ),
            )),
            UIHelper.verticalSpaceLarge,
          ],
        ),
      ),
    );
  }
}
