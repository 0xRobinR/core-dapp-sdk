import 'package:dapp_browser_app/mocks/NetworkData.dart';
import 'package:dapp_browser_app/models/Chain/Chain.dart';
import 'package:dapp_browser_app/models/Chain/Currency.dart';

// Default Chain Instances
Chain ethChain = Chain(
    chainId: 1,
    chainName: "Ethereum Mainnet",
    nativeCurrency:
        Currency.fromJson({"name": "ETH", "symbol": "ETH", "decimals": 18}),
    rpcUrls: ethNetwork.networkRPC);
