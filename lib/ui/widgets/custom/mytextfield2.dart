import 'package:flutter/material.dart';

class MyTextField2 extends StatelessWidget {
  final TextEditingController controllerText;
  final bool invalid;
  final String name;

  const MyTextField2({Key key, this.controllerText, this.name, this.invalid})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controllerText,
      decoration: InputDecoration(
          errorText: invalid ? 'Value Can\'t Be Empty' : null,
          suffixIcon: GestureDetector(
            onTap: () {
              print("clear");
              controllerText.clear();
            },
            child: Icon(
              Icons.clear,
              color: Colors.black26,
            ),
          ),
          hintText: name,
          hintStyle: TextStyle(color: Colors.black26),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blueGrey, width: 5.0),
            borderRadius: BorderRadius.all(Radius.circular(4.0)),
          ),
          contentPadding:
              EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0)),
    );
  }
}
