import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class DialogUtils {
  static DialogUtils _instance = new DialogUtils.internal();

  DialogUtils.internal();

  factory DialogUtils() => _instance;

  static void showTopBoxError(BuildContext context, String text) {
    showTopSnackBar(
      context,
      CustomSnackBar.error(
        message: text,
      ),
    );
  }

  static void showTopBoxSucc(BuildContext context, String text) {
    showTopSnackBar(
      context,
      CustomSnackBar.success(
        message: text,
      ),
    );
  }

  static void showCustomDialog(BuildContext context,
      {@required String title,
      String okBtnText = "Ok",
      String cancelBtnText = "Cancel",
      @required Function okBtnFunction}) {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text(title),
            //content: /* Here add your custom widget  */,
            actions: <Widget>[
              FlatButton(
                  child: Text(cancelBtnText),
                  onPressed: () => Navigator.pop(context)),
              FlatButton(
                child: Text(okBtnText),
                onPressed: okBtnFunction,
              ),
            ],
          );
        });
  }

  static void showSimpleDialog(
    BuildContext context, {
    @required String title,
    String okBtnText = "OK",
    //@required Function okBtnFunction
  }) {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            //title: Text(title),
            content: Text(title),
            actions: <Widget>[
              FlatButton(
                child: Text(okBtnText),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          );
        });
  }

  static void showSimpleDialogOK(BuildContext context,
      {@required String title,
      String okBtnText = "OK",
      @required Function okBtnFunction}) {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            //title: Text(title),
            content: Text(title),
            actions: <Widget>[
              FlatButton(
                child: Text(okBtnText),
                onPressed: okBtnFunction,
              ),
            ],
          );
        });
  }

  static void showPickImage(BuildContext context,
      {@required Function camBtnFunction,
      @required Function folderBtnFunction}) {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text("Select Image source"),
            //content: /* Here add your custom widget  */,
            actions: <Widget>[
              FlatButton(
                child: Text("Camera"),
                onPressed: camBtnFunction,
              ),
              FlatButton(child: Text("Folder"), onPressed: folderBtnFunction)
            ],
          );
        });
  }

  static void showToast(String text) {
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  static void showToastSuccess(String text) {
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
