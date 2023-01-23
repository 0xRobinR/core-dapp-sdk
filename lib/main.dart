import 'dart:collection';
import 'dart:developer';

import 'package:dapp_browser_app/hooks/chainSwitch/hooks.dart';
import 'package:dapp_browser_app/js-injectors/dapp_injector.dart';
import 'package:dapp_browser_app/mocks/ChainData.dart';
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
  InAppWebViewController? _inAppWebViewController;

  final accountDetails = {
    "address": "0x4552B1c4102e54627553FC605D3A0b0B3eE55FdC",
    "privateKey":
        "0x737d71b09722fc356fc5a0dead1deb260627993fc048af957f9e82810277e42a"
  };

  final currentChain = ethChain;

  final GlobalKey webViewKey = GlobalKey();

  reloadPage() async {
    await _inAppWebViewController?.reload();
  }

  initializeControllerListeners(InAppWebViewController _controller) {
    _controller.addJavaScriptHandler(
        handlerName: "eth_requestAccounts",
        callback: (args) {
          logD(args);
          return {
            "success": true,
            "error": null,
            "data": [accountDetails['address']]
          };
        });
    _controller.addJavaScriptHandler(
        handlerName: "wallet_switchEthereumChain",
        callback: (args) =>
            useChainSwitch(context, _controller, currentChain, args));
    _controller.addJavaScriptHandler(
        handlerName: "wallet_addEthereumChain",
        callback: (args) => useAddNewChain(context, _controller, args));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          ElevatedButton.icon(
              onPressed: reloadPage,
              icon: const Icon(Icons.refresh),
              label: const Text("Reload"))
        ],
      ),
      body: InAppWebView(
        initialUrlRequest: URLRequest(
            url: Uri.parse(
                "https://360coreinc.com/testdapp/mywebpage.html?updated=${(DateTime.now().millisecondsSinceEpoch / 1000)}")),
        initialUserScripts: UnmodifiableListView<UserScript>([
          UserScript(
              source: script,
              injectionTime: UserScriptInjectionTime.AT_DOCUMENT_START)
        ]),
        onWebViewCreated: (controller) {
          initializeControllerListeners(controller);
          setState(() {
            _inAppWebViewController = controller;
          });
        },
        onConsoleMessage: (controller, message) {
          logD("console: $message");
        },
        initialOptions: InAppWebViewGroupOptions(
            android: AndroidInAppWebViewOptions(
          cacheMode: AndroidCacheMode.LOAD_NO_CACHE,
        )),
      ),
    );
  }
}

logD(message) {
  log("Logging: $message");
}
