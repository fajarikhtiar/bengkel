import 'package:bengkel/models/cart_accesorie_model.dart';
import 'package:bengkel/models/cart_service_model.dart';
import 'package:bengkel/models/cart_sparepart_model.dart';
import 'package:bengkel/models/transaction_model.dart';
import 'package:bengkel/services/transaction_service.dart';
import 'package:flutter/material.dart';

class TransactionProvider with ChangeNotifier {
  late List<TransactionModel> _transactions;

  List<TransactionModel> get transactions => _transactions;

  set transactions(List<TransactionModel> transaction) {
    _transactions = transactions;
    notifyListeners();
  }

  Future<bool> checkout(
    String customerId,
    String token,
    List<CartSparepartModel> cartSpareparts,
    List<CartAccesorieModel> cartAccesories,
    List<CartServiceModel> cartServices,
    double totalPrice,
  ) async {
    try {
      if (await TransactionService().checkout(customerId, token, cartSpareparts,
          cartAccesories, cartServices, totalPrice)) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> editCheckout(
    String id,
    String customerId,
    String token,
    List<CartSparepartModel> cartSpareparts,
    List<CartAccesorieModel> cartAccesories,
    List<CartServiceModel> cartServices,
    double totalPrice,
  ) async {
    try {
      if (await TransactionService().editCheckout(id, customerId, token,
          cartSpareparts, cartAccesories, cartServices, totalPrice)) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<void> getTransactions() async {
    try {
      List<TransactionModel> transactions =
          await TransactionService().getTransactions();
      _transactions = transactions;
    } catch (e) {
      print(e);
    }
  }
}
