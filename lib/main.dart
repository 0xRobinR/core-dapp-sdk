import 'dart:developer';

import 'package:dapp_browser_app/components/ChainSwitch.dart';
import 'package:dapp_browser_app/mocks/ChainData.dart';
import 'package:dapp_browser_app/models/Chain.dart';
import 'package:dapp_browser_app/models/ChainArgs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:webview_flutter/webview_flutter.dart';

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
    "privateKey": "0x737d71b09722fc356fc5a0dead1deb260627993fc048af957f9e82810277e42a"
  };

  final currentChain = ethChain;

  final GlobalKey webViewKey = GlobalKey();

  reloadPage() async {
    await _inAppWebViewController?.reload();
  }

  initializeControllerListeners(InAppWebViewController _controller) {
    _controller.addJavaScriptHandler(handlerName: "eth_requestAccounts", callback: (args){
      logD(args);
      return {
        "success": true,
        "error": null,
        "data":[accountDetails['address']]
      };
    });
    logD("web view created");
    _controller.addJavaScriptHandler(handlerName: "wallet_switchEthereumChain", callback: (args) async {
      ChainArgs chainArgs = ChainArgs(args[0][0]['chainId']);
      Uri? title = await _controller.getUrl();
      logD("Title page: ${title?.origin}");
      int chainId = int.parse(chainArgs.getChainId);
      Chain? chain = supportedChains[chainId];

      logD("Chain trying to switch: ${chain?.chainId}");

      if ( chain == null ) {
        return {
          "success": false,
          "error": {
            "code": -32603,
            "message": "Unrecognized chain ID $chainId. Try adding the chain using wallet_addEthereumChain first.",
            "data": {
              "code": 4902,
              "message": "Unrecognized chain ID $chainId. Try adding the chain using wallet_addEthereumChain first."
            }
          },
          "data": null
        };
      }

      // showModalBottomSheet(
      //     context: context,
      //     builder: (builder) {
      //       return ChainSwitch(
      //         currentChain: '',
      //         webTitle: title!.origin,
      //         switchChain: int.parse(chainArgs.getChainId).toString()
      //       );
      //     }
      // );
      return null;
    });
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
            label: const Text("Reload")
          )
        ],
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
          )
        ),
      ),
    );
  }
}


logD(message) {
  log("Logging: $message");
}