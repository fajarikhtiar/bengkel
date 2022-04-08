import 'package:bengkel/models/cart_sparepart_model.dart';
import 'package:bengkel/models/sparepart_model.dart';
import 'package:bengkel/models/transaction_model.dart';
import 'package:bengkel/providers/cart_provider.dart';
import 'package:bengkel/providers/sparepart_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddSparepartPage extends StatelessWidget {
  const AddSparepartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String idTransaction = '';
    SparepartProvider sparepartProvider =
        Provider.of<SparepartProvider>(context);
    CartProvider cartProvider = Provider.of<CartProvider>(context);
    if (ModalRoute.of(context)!.settings.arguments != null) {
      TransactionModel transaction =
          ModalRoute.of(context)!.settings.arguments as TransactionModel;
      cartProvider.cartSpareparts = transaction.spareparts;
      cartProvider.cartAccesories = transaction.accesories;
      cartProvider.cartServices = transaction.services;
      cartProvider.customer = transaction.customer;
      idTransaction = transaction.id.toString();
    }

    Widget cardSparepartItem(CartSparepartModel cart) {
      return Container(
        child: Row(
          children: [
            Expanded(child: Text(cart.sparepart.name)),
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      cartProvider.reduceQuantity(cart.id, 'sparepart');
                    },
                    icon: Icon(Icons.remove)),
                Text(cart.qtySparepart.toString()),
                IconButton(
                    onPressed: () {
                      cartProvider.addQuantity(cart.id, 'sparepart');
                    },
                    icon: Icon(Icons.add)),
              ],
            )
          ],
        ),
      );
    }

    Widget sparepartCard(SparepartModel sparepart) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: EdgeInsets.all(10),
            child: Text(sparepart.name),
          ),
          IconButton(
              onPressed: () {
                cartProvider.addSparepart(sparepart);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: Colors.green,
                    content: Text(
                      'Berhasil ditambahkan',
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              },
              icon: Icon(Icons.add)),
        ],
      );
    }

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.arrow_forward),
        onPressed: () {
          Navigator.pushNamed(
            context,
            '/transaction-accesorie',
            arguments: idTransaction,
          );
        },
      ),
      appBar: AppBar(
        title: Text('Tambah Transaksi'),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20),
        children: [
          Text(
            'Nama Pelanggan : ${cartProvider.customer.name}',
            style: TextStyle(fontSize: 30),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            'Pilih Sparepart',
            style: TextStyle(fontSize: 20),
          ),
          Container(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: sparepartProvider.spareparts
                    .map((sparepart) => sparepartCard(sparepart))
                    .toList()),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            'Daftar sparepart ditambahkan',
            style: TextStyle(fontSize: 20),
          ),
          Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.all(10),
            child: Column(
              children: cartProvider.cartSpareparts
                  .map((e) => cardSparepartItem(e))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
