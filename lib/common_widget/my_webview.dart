import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'hexcolor.dart';

class MyWebView extends StatefulWidget {



  var title;
  var urlStr;

  MyWebView(this.title,this.urlStr);
  // MyWebView(this.title,this.urlStr, {Key? key}) : super(key: key)

  _MyWebViewState createState() => _MyWebViewState();
}

class _MyWebViewState extends State<MyWebView> {

  double lineProgress = 0.0;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        bottom: PreferredSize(
          child: _progressBar(lineProgress,context),
          preferredSize: Size.fromHeight(3.0),
        ),
      ),
      body: Builder(builder: (BuildContext context) {
        return WebView(
          initialUrl: widget.urlStr,
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController) {
            // _controller.complete(webViewController);
          },
          onProgress: (int progress) {
            print("WebView is loading (progress : $progress)");
            setState(() {

              lineProgress = progress.toDouble()/100;
            });

          },
          javascriptChannels: <JavascriptChannel>{
            // _toasterJavascriptChannel(context),
          },
          navigationDelegate: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              print('blocking navigation to $request}');
              return NavigationDecision.prevent;
            }
            print('allowing navigation to $request');
            return NavigationDecision.navigate;
          },
          onPageStarted: (String url) {
            print('Page started loading: $url');
          },
          onPageFinished: (String url) {
            print('Page finished loading: $url');
          },
          gestureNavigationEnabled: true,
        );
      }),
    );
  }

  _progressBar(double progress,BuildContext context) {

    return LinearProgressIndicator(
      backgroundColor: Colors.white70.withOpacity(0),
      value: progress == 1.0 ? 0 : progress,
      valueColor: new AlwaysStoppedAnimation<Color>(HexColor('#567BFD')),
    );
  }
}
