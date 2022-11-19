import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider_arc/ui/shared/app_colors.dart';

class Loading extends StatelessWidget {
  final bool small;

  const Loading({Key key, this.small}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return small == null
        ? Center(
            child: SpinKitDoubleBounce(color: PrimaryColor),
          )
        : Center(
            child: SpinKitFadingCircle(color: PrimaryColor),
          );
  }
}
