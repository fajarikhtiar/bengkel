import 'package:bengkel/providers/auth_provider.dart';
import 'package:bengkel/providers/cart_provider.dart';
import 'package:bengkel/providers/transaction_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditTransactionPage extends StatelessWidget {
  const EditTransactionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CartProvider cartProvider = Provider.of<CartProvider>(context);
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    TransactionProvider transactionProvider =
        Provider.of<TransactionProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Transaction'),
      ),
    );
  }
}
