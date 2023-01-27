import 'dart:convert';

import 'package:dapp_browser_app/config/constants.dart';
import 'package:dapp_browser_app/main.dart';
import 'package:dapp_browser_app/storage/preferences.dart';

class Whitelist {
  final String uri;

  const Whitelist({required this.uri});

  Map<String, dynamic> toMap() {
    return {"uri": uri};
  }

  @override
  String toString() {
    // TODO: implement toString
    return "Whitelist(uri: $uri)";
  }

  Future<bool> isWhitelisted() async {
    final stored = await getStored(whitelistKey, defaultValue: "{}");
    logD(stored);
    Map<String, bool> whitelistAddresses =
        Map<String, bool>.from(jsonDecode(stored));
    logD(whitelistAddresses);
    return whitelistAddresses[uri] ?? false;
  }

  Future<bool> setWhitelist(bool status) async {
    final stored = await getStored(whitelistKey, defaultValue: "{}");
    Map<String, bool> whitelistAddresses =
        Map<String, bool>.from(jsonDecode(stored));
    whitelistAddresses[uri] = status;
    logD(whitelistAddresses);
    final response = await setStored(
        key: whitelistKey, value: jsonEncode(whitelistAddresses));
    return response;
  }
}
