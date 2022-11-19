
import 'package:flutter/material.dart';
import 'package:kf_drawer/kf_drawer.dart';
import 'package:provider_arc/core/constants/app_contstants.dart';
import 'package:provider_arc/ui/shared/text_styles.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends KFDrawerContent {
  final String title;
  final String url;

  WebViewPage(this.title, this.url);
  @override
  WebViewExampleState createState() => WebViewExampleState();
}

class WebViewExampleState extends State<WebViewPage> {

  @override
  void initState() {
    super.initState();
    // Enable hybrid composition.
    //if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        //title: Text("Terms and Agreement", style: TitleStyle,),
        title: Text(widget.title, style: TitleStyle,),
        leading: new IconButton(
          icon: new Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: widget.onMenuPressed,
        ),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: WebView(
          //initialUrl: KEYS.endpoint + '/public/pages/agreement.html',
            initialUrl: KEYS.endpoint + widget.url
        ),
      ),
    );
  }
}
