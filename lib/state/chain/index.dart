import 'dart:convert';

import 'package:dapp_browser_app/config/constants.dart';
import 'package:dapp_browser_app/main.dart';
import 'package:dapp_browser_app/mocks/ChainData.dart';
import 'package:dapp_browser_app/models/Chain/Chain.dart';
import 'package:dapp_browser_app/storage/preferences.dart';
import 'package:get/get.dart';

class ChainController extends GetxController {
  final Rx<Chain> _currentChain = ethChain.obs;
  final RxMap<String, Chain> _supportedChains = <String, Chain>{}.obs;

  setChain(Chain chain) {
    _currentChain.value = chain;
    update();
  }

  Future addChain(Chain chain) async {
    _supportedChains[chain.chainId.toString()] = chain;
    final storedChain = await getStored(chainListKey, defaultValue: "{}");
    final decoded = Map<String, String>.from(jsonDecode(storedChain));
    if (decoded[chain.chainId.toString()].isNull) {
      decoded[chain.chainId.toString()] = jsonEncode(chain.toJson());
      logD(decoded);
      await setStored(key: chainListKey, value: jsonEncode(decoded));
    } else {
      logD("Already Stored!");
      logD(decoded);
    }
  }

  Chain getChain() => _currentChain.value;

  Future<Map<String, Chain?>> getSupportedChains() async {
    final storedChain = await getStored(chainListKey, defaultValue: "{}");
    if (storedChain == "{}") {
      return _supportedChains;
    } else {
      logD("passed");
      final decoded = Map<dynamic, dynamic>.from(jsonDecode(storedChain));
      logD("now we are here");
      logD(decoded);
      Map<String, Chain?> chains = {};
      decoded.forEach((key, value) {
        chains[key.toString()] = Chain.fromJson(jsonDecode(value));
      });
      return chains;
    }
  }
}
