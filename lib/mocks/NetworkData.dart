// import 'package:dapp_browser_app/models/Chain/Gas.dart';
import 'package:dapp_browser_app/models/Chain/Network.dart' as net;
// import 'package:flutter_web3/ethers.dart';
//
// Gas ethGas = Gas(
//     gasLimit: BigNumber.from("500000"), gasPrice: BigNumber.from("1000000000"));

net.Network ethNetwork = net.Network(networkRPC: ["https://rpc.ankr.com/eth"]);

net.Network bnbNetwork =
    net.Network(networkRPC: ["https://bsc-dataseed4.ninicoin.io"]);

net.Network bnbTestNetwork =
    net.Network(networkRPC: ["https://data-seed-prebsc-2-s3.binance.org:8545"]);
