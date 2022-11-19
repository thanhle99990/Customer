import 'package:flutter/material.dart';
import 'package:provider_arc/ui/shared/app_colors.dart';
import 'package:provider_arc/ui/shared/ui_helpers.dart';
import 'package:provider_arc/ui/widgets/custom/mytext.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController controllerText;
  final String name;
  final TextInputType textInputType;

  const MyTextField(
      {Key key, this.controllerText, this.name, this.textInputType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        MyH2(text: name),
        UIHelper.verticalSpaceSmall,
        TextField(
          controller: controllerText,
          keyboardType: textInputType,
          decoration: InputDecoration(
              hintText: name,
              hintStyle: TextStyle(color: Colors.black26),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: LightGrey, width: 5.0),
                borderRadius: BorderRadius.all(Radius.circular(12.0)),
              ),
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0)),
        ),
        UIHelper.verticalSpaceSmall
      ],
    );
  }
}
