import 'dart:io';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/foundation.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage()
    );
  }
}

class HomePage extends StatelessWidget {
  void _handleURLButtonPress(BuildContext context, String url, String title) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => WebViewPage(url, title)));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("WebView Payment"),
      ),
      body: Center(
        child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          MaterialButton(
            color: Colors.green,
            child: Text(
              "Tap to Pay",
              style: TextStyle(color: Colors.white70, fontWeight: FontWeight.bold),
            ),
            onPressed: () {
              _handleURLButtonPress(
                  context, "https://payanyway.herokuapp.com/", "Mamont.pay");
            },
          ),
        ],
      )),
    );
  }
}

class WebViewPage extends StatefulWidget {
  final String url;
  final String title;

  WebViewPage(this.url, this.title);

  @override
  WebViewPageState createState() =>
      WebViewPageState(this.url, this.title);
}

class WebViewPageState extends State<WebViewPage> {
  final String url;
  final String title;

  WebViewPageState(this.url, this.title);

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.title),
      ),
      body: Column(children: [
        Expanded(
            child: WebView(
                initialUrl: this.url,
                javascriptMode: JavascriptMode.unrestricted
            )
        )
      ])
    );
  }
}