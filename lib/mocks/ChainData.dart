import 'package:dapp_browser_app/models/Chain.dart';

// Default Chain Instances
Chain ethChain = Chain(
    chainId: 1, chainName: "Ethereum Mainnet", chainSymbol: "ETH"
);

Chain bnbChain = Chain(
  chainId: 56, chainName: "Binance Smart Chain", chainSymbol: "BNB"
);

Chain bnbTestChain = Chain(
    chainId: 97, chainName: "BSC Testnet", chainSymbol: "tBNB"
);

Map<int, Chain> supportedChains = {
  1: ethChain,
  56: bnbChain,
  97: bnbTestChain
};

