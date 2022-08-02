import 'package:flutter_web3/ethers.dart';

class Gas {
  BigNumber gasPrice;
  BigNumber gasLimit;

  Gas({required this.gasLimit, required this.gasPrice});
}