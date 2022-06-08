import 'package:cryptop/app/dependency.dart';
import 'package:cryptop/models/wallet_model.dart';
import 'package:cryptop/services/wallet_service.dart';
import 'package:flutter/cupertino.dart';

class WalletViewmodel extends ChangeNotifier {
  Wallet? wallet;
  WalletService get rest => dependency();

  Future<Wallet?> getWallet() async {
    wallet = await rest.getWallet();
    return wallet;
  }

  Future<Wallet?> setWallet(Map<String, dynamic> data) async {
    final wallet = await rest.setWallet(data);
    return wallet;
  }
}
