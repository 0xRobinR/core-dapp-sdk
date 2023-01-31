import 'dart:collection';
import 'dart:developer';

import 'package:dapp_browser_app/functions/accounts/AccountInfo.dart';
import 'package:dapp_browser_app/functions/chain/AddChain.dart';
import 'package:dapp_browser_app/functions/chain/ChainSwitch.dart';
import 'package:dapp_browser_app/js-injectors/dapp_injector.dart';
import 'package:dapp_browser_app/mocks/ChainData.dart';
import 'package:dapp_browser_app/state/account/index.dart';
import 'package:dapp_browser_app/state/chain/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';

void main() {
  runApp(const GetMaterialApp(home: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'core dApp browser'),
      debugShowCheckedModeBanner: false,
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

  final Account account = Get.put(Account());
  final ChainController chainController = Get.put(ChainController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    account.addAccount(accountDetails['address']);
    chainController.setChain(ethChain);
    chainController.addChain(ethChain);
  }

  final GlobalKey webViewKey = GlobalKey();

  reloadPage() async {
    await _inAppWebViewController?.reload();
  }

  initializeControllerListeners(InAppWebViewController _controller) {
    _controller.addJavaScriptHandler(
        handlerName: "eth_requestAccounts",
        callback: (args) =>
            handleRequestAccount(context: context, controller: _controller));

    _controller.addJavaScriptHandler(
        handlerName: "wallet_switchEthereumChain",
        callback: (args) => handleChainSwitch(
            context: context, controller: _controller, args: args));

    _controller.addJavaScriptHandler(
        handlerName: "wallet_addEthereumChain",
        callback: (args) => handleAddChain(
            context: context, controller: _controller, args: args));
    _controller.addJavaScriptHandler(
        handlerName: "eth_chainId",
        callback: (args) {
          return {
            "success": true,
            "error": false,
            "data":
                "0x${(chainController.getChain().chainId.toRadixString(16))}"
          };
        });
    _controller.addJavaScriptHandler(
        handlerName: "eth_accounts",
        callback: (args) {
          print(args);
          return {
            "success": true,
            "error": false,
            "data": [accountDetails['address']]
          };
        });
    _controller.addJavaScriptHandler(
        handlerName: "eth_gasPrice",
        callback: (args) {
          print(args);
          return {"success": true, "error": false, "data": 0};
        });
    _controller.addJavaScriptHandler(
        handlerName: "eth_call",
        callback: (args) {
          print(args);
          return {"success": true, "error": false, "data": {}};
        });
    _controller.addJavaScriptHandler(
        handlerName: "eth_blockNumber",
        callback: (args) {
          print(args);
          return {"success": true, "error": false, "data": 18282};
        });
    _controller.addJavaScriptHandler(
        handlerName: "eth_estimateGas",
        callback: (args) {
          print(args);
          return {"success": true, "error": false, "data": "382388"};
        });
    _controller.addJavaScriptHandler(
        handlerName: "eth_sendTransaction",
        callback: (args) {
          print({"called": true});
          print(args);
          return {
            "success": true,
            "error": false,
            "data":
                "0xf0da23ae58f8892f55863aaec935675fb6620fdd6db3ad48f1bb5e7d6783f90d"
          };
        });
    _controller.addJavaScriptHandler(
        handlerName: "eth_getTransactionByHash",
        callback: (args) {
          print(args);
          return {
            "success": true,
            "error": false,
            "data": {
              "blockHash":
                  "0x10d00c12a05e2105b45cb897659491c84af2bc9e6d30bdd0e74699e1e02f8786",
              "blockNumber": "0x5daf3b",
              "from": "0xa7d9ddbe1f17865597fbd27ec712455208b6b76d",
              "gas": "0xc350",
              "gasPrice": "0x4a817c800",
              "hash":
                  "0xf0da23ae58f8892f55863aaec935675fb6620fdd6db3ad48f1bb5e7d6783f90d",
              "input": "0x68656c6c6f21",
              "nonce": "0x15",
              "to": "0xf02c1c8e6114b1dbe8937a39260b5b0a374432bb",
              "transactionIndex": "0x41",
              "value": "0xf3dbb76162000",
              "v": "0x25",
              "r":
                  "0x1b5e176d927f8e9ab405058b2d2457392da3e20f328b16ddabcebc33eaac5fea",
              "s":
                  "0x4ba69724e8f69de52f0125ad8b3c5c2cef33019bac3249e2c0a2192766d1721c"
            }
          };
        });
  }

  String uri = "https://pancakeswap.finance";
  // "https://360coreinc.com/testdapp/mywebpage.html?updated=${(DateTime.now().millisecondsSinceEpoch / 1000)}";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        leading: GetBuilder<ChainController>(
          builder: (con) {
            return Text("${con.getChain().chainId}");
          },
        ),
        actions: [
          ElevatedButton.icon(
              onPressed: reloadPage,
              icon: const Icon(Icons.refresh),
              label: const Text("Reload"))
        ],
      ),
      body: InAppWebView(
        initialUrlRequest: URLRequest(url: Uri.parse(uri)),
        initialUserScripts: UnmodifiableListView<UserScript>([]),
        onWebViewCreated: (controller) {
          controller.addUserScript(
              userScript: UserScript(
                  source: script,
                  injectionTime: UserScriptInjectionTime.AT_DOCUMENT_START));
          initializeControllerListeners(controller);
          setState(() {
            _inAppWebViewController = controller;
          });
        },
        onLoadStart: (controller, _) {
          log("loaded content");
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
