import 'package:get/get.dart';

import '../../models/Wallet/index.dart';

class Account extends GetxController {
  final RxList<Wallet> wallets = <Wallet>[].obs;
  Account();

  addAccount(address) => wallets.add(Wallet(publicKey: address));
  getAccounts() {
    return wallets.map((element) => element.publicKey).toList();
  }
}
