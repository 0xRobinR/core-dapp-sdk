import 'package:dapp_browser_app/models/Storage/Whitelist.dart';

Future<bool> isWhitelistedUri({required String uri}) async {
  final whitelist = Whitelist(uri: uri);
  return await whitelist.isWhitelisted();
}

Future<bool> whitelistUri({required String uri}) async {
  final whitelist = Whitelist(uri: uri);
  return await whitelist.setWhitelist(true);
}

Future<bool> blacklistUri({required String uri}) async {
  final whitelist = Whitelist(uri: uri);
  return await whitelist.setWhitelist(false);
}
