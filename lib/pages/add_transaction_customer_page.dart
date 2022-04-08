import 'package:bengkel/models/customer_model.dart';
import 'package:bengkel/providers/cart_provider.dart';
import 'package:bengkel/providers/customer_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddTransaction extends StatelessWidget {
  const AddTransaction({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CustomerProvider customerProvider = Provider.of<CustomerProvider>(context);
    CartProvider cartProvider = Provider.of<CartProvider>(context);

    Widget customerCard(CustomerModel customer) {
      return GestureDetector(
        onTap: () {
          cartProvider.customer = customer;
          Navigator.pushNamed(context, '/transaction-sparepart');
        },
        child: Container(
          width: 150,
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.all(10),
          color: Colors.blueGrey,
          child: Text(customer.name),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah Transaksi'),
      ),
      body: ListView(
        children: [
          Text(
            'Pilih Pelanggan',
            style: TextStyle(fontSize: 30),
          ),
          Container(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: customerProvider.customers
                    .map((customer) => customerCard(customer))
                    .toList()),
          )
        ],
      ),
    );
  }
}
