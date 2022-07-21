import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        //
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);



  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final accountDetails = {
    "address": "0x4552B1c4102e54627553FC605D3A0b0B3eE55FdC",
    "privateKey": "0x737d71b09722fc356fc5a0dead1deb260627993fc048af957f9e82810277e42a"
  };

  final chainDetails = [

  ];

  final GlobalKey webViewKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: InAppWebView(
        initialUrlRequest: URLRequest(
          url: Uri.parse(
            "https://360coreinc.com/testdapp/mywebpage.html?updated=${(DateTime.now().millisecondsSinceEpoch / 1000)}"
          )
        ),
        onLoadStart: (controller, url) async {
          await controller.injectJavascriptFileFromAsset(
            assetFilePath: "assets/main.js"
          );
        },
        onWebViewCreated: (controller) async {
          controller.addJavaScriptHandler(handlerName: "eth_requestAccounts", callback: (args){
            logD(args);
            return [ accountDetails['address'] ];
          });
        },
        onConsoleMessage: (controller, message) {
          logD("console: $message");
        },
        initialOptions: InAppWebViewGroupOptions(
          android: AndroidInAppWebViewOptions(
            cacheMode: AndroidCacheMode.LOAD_NO_CACHE,
          )
        ),
      ),
    );
  }
}


logD(message) {
  log("Logging: $message");
}