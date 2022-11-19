import 'package:avatar_view/avatar_view.dart';
import 'package:flutter/material.dart';
import 'package:provider_arc/ui/shared/app_colors.dart';

class MyAvatarC extends StatelessWidget {
  final url;
  final double size;

  const MyAvatarC({Key key, this.url, this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AvatarView(
      radius: size == null ? 50 : size,
      borderColor: PrimaryColor,
      avatarType: AvatarType.CIRCLE,
      backgroundColor: Colors.red,
      imagePath: url,
      placeHolder: Container(
        child: Icon(
          Icons.person,
          size: 50,
        ),
      ),
      errorWidget: Container(
        child: Icon(
          Icons.error,
          size: 50,
        ),
      ),
    );
  }
}

class MyAvatarR extends StatelessWidget {
  final url;
  final double size;

  const MyAvatarR({Key key, this.url, this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AvatarView(
      radius: size,
      borderColor: PrimaryColor,
      avatarType: AvatarType.RECTANGLE,
      backgroundColor: Colors.red,
      imagePath: url,
      placeHolder: Container(
        child: Icon(
          Icons.person,
          size: 50,
        ),
      ),
      errorWidget: Container(
        child: Icon(
          Icons.error,
          size: 50,
        ),
      ),
    );
  }
}
