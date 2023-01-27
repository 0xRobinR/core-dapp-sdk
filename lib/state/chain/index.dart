import 'dart:convert';

import 'package:dapp_browser_app/config/constants.dart';
import 'package:dapp_browser_app/main.dart';
import 'package:dapp_browser_app/mocks/ChainData.dart';
import 'package:dapp_browser_app/models/Chain/Chain.dart';
import 'package:dapp_browser_app/storage/preferences.dart';
import 'package:get/get.dart';

class ChainController extends GetxController {
  final Rx<Chain> _currentChain = ethChain.obs;
  final RxMap<int, Chain> _supportedChains = <int, Chain>{}.obs;

  setChain(Chain chain) {
    _currentChain.update((val) => chain);
  }

  Future addChain(Chain chain) async {
    _supportedChains[chain.chainId] = chain;
    final storedChain = await getStored(chainListKey, defaultValue: "{}");
    final decoded = Map<int, String>.from(jsonDecode(storedChain));
    decoded[chain.chainId] = jsonEncode(chain.toJson());
    logD(decoded);
    await setStored(key: chainListKey, value: jsonEncode(decoded));
  }

  Chain getChain() => _currentChain.value;

  Future<Map<int, Chain?>> getSupportedChains() async {
    final storedChain = await getStored(chainListKey, defaultValue: "{}");
    if (storedChain == "{}") {
      return _supportedChains;
    } else {
      final decoded = jsonDecode(storedChain) as Map<int, Chain?>;
      return decoded;
    }
  }
}
