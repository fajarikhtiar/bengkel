import 'package:bengkel/providers/accesorie_provider.dart';
import 'package:bengkel/providers/customer_provider.dart';
import 'package:bengkel/providers/service_provider.dart';
import 'package:bengkel/providers/sparepart_provider.dart';
import 'package:bengkel/providers/transaction_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    getInit();
    super.initState();
  }

  getInit() async {
    await Provider.of<CustomerProvider>(context, listen: false).getCustomers();
    await Provider.of<AccesorieProvider>(context, listen: false)
        .getAccesories();
    await Provider.of<ServiceProvider>(context, listen: false).getServices();
    await Provider.of<SparepartProvider>(context, listen: false)
        .getSpareparts();
    await Provider.of<TransactionProvider>(context, listen: false)
        .getTransactions();
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
          child: Icon(
        Icons.car_repair,
        size: 150,
      )),
    );
  }
}
