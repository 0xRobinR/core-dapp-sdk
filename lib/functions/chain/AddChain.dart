import 'package:dapp_browser_app/components/AddChain.dart';
import 'package:dapp_browser_app/eth-utils/rpcResponse.dart';
import 'package:dapp_browser_app/main.dart';
import 'package:dapp_browser_app/models/Chain/Chain.dart';
import 'package:dapp_browser_app/models/Chain/ChainArgs.dart';
import 'package:dapp_browser_app/state/chain/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';

handleAddChain(
    {required BuildContext context,
    required InAppWebViewController controller,
    List<dynamic>? args}) async {
  ChainController chainController = Get.find();
  ChainArgs chainArgs = ChainArgs(args?[0][0]['chainId']);
  Uri? title = await controller.getUrl();
  logD("Title page: ${title?.origin}");

  Map<String, Chain?> _supportedChains =
      await chainController.getSupportedChains();
  Chain? chain = _supportedChains[int.parse(chainArgs.getChainId).toString()];

  logD("Chain trying to switch: ${chain?.chainId}");
  logD("args ${args?[0][0]}");

  if (chain == null) {
    logD("adding chain");
    final response = await showModalBottomSheet(
        context: context,
        isDismissible: false,
        builder: (builder) {
          return AddChain(
            webTitle: title!.origin,
            addChain: int.parse(chainArgs.getChainId).toString(),
            onAccept: () {
              Navigator.pop(context, true);
            },
            onReject: () {
              Navigator.pop(context, false);
            },
          );
        });

    if (response) {
      Chain c = Chain.fromJson(args?[0][0]);
      chainController.addChain(c);
      return buildSuccess(data: true);
    } else {
      return buildError(
          code: 4001, message: "Adding request was declined by the user");
    }
  }
}
