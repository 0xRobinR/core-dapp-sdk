import 'package:dapp_browser_app/eth-utils/rpcMethods.dart';
import 'package:dapp_browser_app/functions/accounts/AccountInfo.dart';
import 'package:dapp_browser_app/functions/chain/AddChain.dart';
import 'package:dapp_browser_app/functions/chain/ChainSwitch.dart';
import 'package:dapp_browser_app/models/Rpc/RpcCall.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

Map<
    String,
    Function(
        {required BuildContext context,
        required InAppWebViewController controller,
        List<dynamic>? args})> rpcHandlers = {
  "eth_requestAccounts": handleRequestAccount,
  "wallet_switchEthereumChain": handleChainSwitch,
  "wallet_addEthereumChain": handleAddChain
};

// Mapping rpcCalls to RpcCall class.
List<RpcCall> rpcMethods = rpcCalls.map((e) {
  return RpcCall(name: e, handler: () {});
}).toList();
