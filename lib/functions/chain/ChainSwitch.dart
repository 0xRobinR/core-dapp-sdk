import 'package:dapp_browser_app/components/ChainSwitch.dart';
import 'package:dapp_browser_app/eth-utils/rpcResponse.dart';
import 'package:dapp_browser_app/main.dart';
import 'package:dapp_browser_app/models/Chain/Chain.dart';
import 'package:dapp_browser_app/models/Chain/ChainArgs.dart';
import 'package:dapp_browser_app/state/chain/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';

handleChainSwitch(
    {required BuildContext context,
    required InAppWebViewController controller,
    List<dynamic>? args}) async {
  ChainController chainController = Get.find();
  Chain currentChain = chainController.getChain();

  ChainArgs chainArgs = ChainArgs(args?[0][0]['chainId']);
  Uri? title = await controller.getUrl();
  logD("Title page: ${title?.origin}");
  int chainId = int.parse(chainArgs.getChainId);
  Map<String, Chain?> _supportedChains =
      await chainController.getSupportedChains();
  Chain? chain = _supportedChains[chainId.toString()];

  if (chainId == currentChain.chainId) {
    Get.snackbar("Chain", "Already connected to chain id $chainId",
        snackPosition: SnackPosition.BOTTOM);
    return buildSuccess(data: true);
  }

  logD("Chain trying to switch: ${chain?.chainId}");

  if (chain == null) {
    return buildError(
        code: 4902,
        message:
            "Unrecognized chain ID $chainId. Try adding the chain using wallet_addEthereumChain first.");
  }

  bool response = await showModalBottomSheet(
      context: context,
      builder: (builder) {
        return ChainSwitch(
          currentChain: currentChain.chainName,
          webTitle: title!.origin,
          switchChain: int.parse(chainArgs.getChainId).toString(),
          onAccept: () {
            Navigator.pop(context, true);
          },
          onReject: () {
            Navigator.pop(context, false);
          },
        );
      });
  if (response) {
    logD("Changing chain");
    await chainController.setChain(chain);
    return buildSuccess(data: true);
  } else {
    logD("error");
    return buildError(
        code: 4001,
        message:
            "Unable to switch network to ${int.parse(chainArgs.getChainId)}");
  }
}
