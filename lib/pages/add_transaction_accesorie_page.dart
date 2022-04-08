import 'package:bengkel/models/cart_accesorie_model.dart';
import 'package:bengkel/models/accesorie_model.dart';
import 'package:bengkel/providers/cart_provider.dart';
import 'package:bengkel/providers/accesorie_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddAccesoriePage extends StatelessWidget {
  const AddAccesoriePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AccesorieProvider accesorieProvider =
        Provider.of<AccesorieProvider>(context);
    CartProvider cartProvider = Provider.of<CartProvider>(context);
    String idTransaction = ModalRoute.of(context)!.settings.arguments as String;

    Widget cardaccesorieItem(CartAccesorieModel cart) {
      return Container(
        child: Row(
          children: [
            Expanded(child: Text(cart.accesorie.name)),
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      cartProvider.reduceQuantity(cart.id, 'accesorie');
                    },
                    icon: Icon(Icons.remove)),
                Text(cart.qtyAccesorie.toString()),
                IconButton(
                    onPressed: () {
                      cartProvider.addQuantity(cart.id, 'accesorie');
                    },
                    icon: Icon(Icons.add)),
              ],
            )
          ],
        ),
      );
    }

    Widget accesorieCard(AccesorieModel accesorie) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: EdgeInsets.all(10),
            child: Text(accesorie.name),
          ),
          IconButton(
              onPressed: () {
                cartProvider.addAccesorie(accesorie);
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
            '/transaction-service',
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
            'Pilih accesorie',
            style: TextStyle(fontSize: 20),
          ),
          Container(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: accesorieProvider.accesories
                    .map((accesorie) => accesorieCard(accesorie))
                    .toList()),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            'Daftar accesorie ditambahkan',
            style: TextStyle(fontSize: 20),
          ),
          Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.all(10),
            child: Column(
              children: cartProvider.cartAccesories
                  .map((e) => cardaccesorieItem(e))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
