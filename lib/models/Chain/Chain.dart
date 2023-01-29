import 'Currency.dart';

class Chain {
  int chainId;
  String chainName;
  Currency nativeCurrency;
  List<String>? rpcUrls;
  List<String>? blockExplorerUrls;
  List<String>? iconUrls;

  Chain(
      {required this.chainId,
      required this.chainName,
      this.rpcUrls,
      required this.nativeCurrency,
      this.blockExplorerUrls,
      this.iconUrls});

  static Chain fromJson(json) {
    return Chain(
      chainId: int.parse(json['chainId'].toString()),
      chainName: json['chainName'],
      nativeCurrency: Currency.fromJson(json['nativeCurrency']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "chainId": chainId,
      "chainName": chainName,
      "nativeCurrency": {
        "name": nativeCurrency.name,
        "symbol": nativeCurrency.symbol,
        "decimals": nativeCurrency.decimals
      },
      "rpcUrls": rpcUrls,
      "blockExplorerUrls": blockExplorerUrls,
      "iconUrls": iconUrls
    };
  }
}
