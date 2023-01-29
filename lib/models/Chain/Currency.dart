import 'package:dapp_browser_app/main.dart';

class Currency {
  String name;
  String symbol;
  int decimals;

  Currency({required this.name, required this.decimals, required this.symbol});

  static Currency fromJson(json) {
    logD(json);
    return Currency(
        name: json['name'],
        decimals: int.parse(json['decimals'].toString()),
        symbol: json['symbol']);
  }
}
