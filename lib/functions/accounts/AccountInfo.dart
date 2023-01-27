import 'package:dapp_browser_app/components/ConnectSheet.dart';
import 'package:dapp_browser_app/eth-utils/rpcResponse.dart';
import 'package:dapp_browser_app/state/account/index.dart';
import 'package:dapp_browser_app/storage/whitelist_uri.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';

handleRequestAccount(
    {required BuildContext context,
    required InAppWebViewController controller,
    List<dynamic>? args}) async {
  final Account account = Get.find();
  final uri = await controller.getUrl();
  final checkWhitelist = await isWhitelistedUri(uri: uri?.host ?? "");

  if (checkWhitelist) {
    return buildSuccess(data: account.getAccounts());
  }
  final authorized = await showModalBottomSheet(
      context: context,
      isDismissible: false,
      builder: (builder) {
        return ConnectSheet(onPressed: () async {
          Navigator.pop(context, true);
        }, onReject: () async {
          Navigator.pop(context, false);
        });
      });
  if (authorized) {
    whitelistUri(uri: uri?.host ?? "");
    return buildSuccess(data: account.getAccounts());
  } else {
    blacklistUri(uri: uri?.host ?? "");
    return buildError(code: 4001, message: "User rejected request");
  }
}
