import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:provider_arc/core/utils/device_utils.dart';
import 'package:provider_arc/ui/shared/app_colors.dart';

class AgreementView extends StatefulWidget {
  @override
  _AgreementViewState createState() => _AgreementViewState();
}

class _AgreementViewState extends State<AgreementView> {
  String link;

  void initState() {
    super.initState();
    _getlink();
  }

  _getlink() async {
    String _link = await Utils.getEndpoint() + '/public/pages/agreement.html';
    setState(() {
      link = _link;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        "/": (_) => SafeArea(
              child: new WebviewScaffold(
                url: link,
                appBar: new AppBar(
                  actions: <Widget>[
                    FlatButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'I\'m agree',
                        style: TextStyle(
                            color: PrimaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                    )
                    /* MyButtonO(caption: 'I\'m agree', fullsize: false, onPressed: (){
                  Navigator.pop(context);
                },)*/
                  ],
                  backgroundColor: LightColor,
                  //title: new Text("User Terms and Agreement"),
                  /*leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () => Navigator.pop(context, false),
              ),*/
                ),
              ),
            ),
      },
    );
  }
}
