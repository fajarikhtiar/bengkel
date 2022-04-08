import 'package:bengkel/pages/add_customer.dart';
import 'package:bengkel/pages/add_transaction_accesorie_page.dart';
import 'package:bengkel/pages/add_transaction_customer_page.dart';
import 'package:bengkel/pages/add_transaction_service_page.dart';
import 'package:bengkel/pages/add_transaction_sparepart_page.dart';
import 'package:bengkel/pages/checkout_page.dart';
import 'package:bengkel/pages/customer_page.dart';
import 'package:bengkel/pages/edit_customer.dart';
import 'package:bengkel/pages/edit_transaction_page.dart';
import 'package:bengkel/pages/home_page.dart';
import 'package:bengkel/pages/login_page.dart';
import 'package:bengkel/pages/register_page.dart';
import 'package:bengkel/pages/splash_page.dart';
import 'package:bengkel/pages/transaction_page.dart';
import 'package:bengkel/providers/accesorie_provider.dart';
import 'package:bengkel/providers/auth_provider.dart';
import 'package:bengkel/providers/cart_provider.dart';
import 'package:bengkel/providers/customer_provider.dart';
import 'package:bengkel/providers/service_provider.dart';
import 'package:bengkel/providers/sparepart_provider.dart';
import 'package:bengkel/providers/transaction_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthProvider()),
        ChangeNotifierProvider(create: (context) => CustomerProvider()),
        ChangeNotifierProvider(create: (context) => TransactionProvider()),
        ChangeNotifierProvider(create: (context) => SparepartProvider()),
        ChangeNotifierProvider(create: (context) => AccesorieProvider()),
        ChangeNotifierProvider(create: (context) => ServiceProvider()),
        ChangeNotifierProvider(create: (context) => CartProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (context) => SplashPage(),
          '/login': (context) => LoginPage(),
          '/register': (context) => RegisterPage(),
          '/home': (context) => HomePage(),
          '/customer': (context) => CustomerPage(),
          '/transaction': (context) => TransactionPage(),
          '/add-customer': (context) => AddCustomer(),
          '/edit-customer': (context) => EditCustomerPage(),
          '/add-transaction': (context) => AddTransaction(),
          '/edit-transaction': (context) => EditTransactionPage(),
          '/checkout': (context) => CheckoutPage(),
          '/transaction-sparepart': (context) => AddSparepartPage(),
          '/transaction-accesorie': (context) => AddAccesoriePage(),
          '/transaction-service': (context) => AddservicePage(),
        },
      ),
    );
  }
}
