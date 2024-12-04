import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewWidget extends StatefulWidget {
  const WebViewWidget({super.key, required this.title, required this.url});

  final String title;
  final String url;

  @override
  WebViewWidgetState createState() => WebViewWidgetState();
}

class WebViewWidgetState extends State<WebViewWidget> {
  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Builder(builder: (_) {
        if (widget.url.isEmpty) {
          return Center(
            child: Text('Homepage is empty'),
          );
        }
        return WebView(
          initialUrl: widget.url,
        );
      }),
    );
  }
}
