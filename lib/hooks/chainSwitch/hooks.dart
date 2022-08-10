import 'package:dapp_browser_app/components/AddChain.dart';
import 'package:dapp_browser_app/components/ChainSwitch.dart';
import 'package:dapp_browser_app/main.dart';
import 'package:dapp_browser_app/mocks/ChainData.dart';
import 'package:dapp_browser_app/models/Chain.dart';
import 'package:dapp_browser_app/models/ChainArgs.dart';
import 'package:flutter/material.dart';

useChainSwitch(context, _controller, currentChain, args) async {
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

  showModalBottomSheet(
      context: context,
      builder: (builder) {
        return ChainSwitch(
            currentChain: currentChain.chainName,
            webTitle: title!.origin,
            switchChain: int.parse(chainArgs.getChainId).toString()
        );
      }
  );
  return null;
}

useAddNewChain(context, _controller, args) async {
  ChainArgs chainArgs = ChainArgs(args[0][0]['chainId']);
  Uri? title = await _controller.getUrl();
  logD("Title page: ${title?.origin}");
  int chainId = int.parse(chainArgs.getChainId);
  Chain? chain = supportedChains[chainId];

  logD("Chain trying to switch: ${chain?.chainId}");

  if ( chain == null ) {
    showModalBottomSheet(
      context: context,
      builder: (builder) {
        return AddChain(
          webTitle: title!.origin,
          addChain: int.parse(chainArgs.getChainId).toString()
        );
      }
    );
  }
}