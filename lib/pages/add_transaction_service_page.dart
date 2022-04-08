import 'package:bengkel/models/cart_service_model.dart';
import 'package:bengkel/models/service_model.dart';
import 'package:bengkel/providers/cart_provider.dart';
import 'package:bengkel/providers/service_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddservicePage extends StatelessWidget {
  const AddservicePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ServiceProvider serviceProvider = Provider.of<ServiceProvider>(context);
    CartProvider cartProvider = Provider.of<CartProvider>(context);
    String idTransaction = ModalRoute.of(context)!.settings.arguments as String;

    Widget cardserviceItem(CartServiceModel cart) {
      return Container(
        child: Row(
          children: [
            Expanded(child: Text(cart.service.name)),
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      cartProvider.reduceQuantity(cart.id, 'service');
                    },
                    icon: Icon(Icons.remove)),
                Text(cart.qtyService.toString()),
                IconButton(
                    onPressed: () {
                      cartProvider.addQuantity(cart.id, 'service');
                    },
                    icon: Icon(Icons.add)),
              ],
            )
          ],
        ),
      );
    }

    Widget serviceCard(ServiceModel service) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: EdgeInsets.all(10),
            child: Text(service.name),
          ),
          IconButton(
              onPressed: () {
                cartProvider.addservice(service);
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
            '/checkout',
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
            'Pilih service',
            style: TextStyle(fontSize: 20),
          ),
          Container(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: serviceProvider.services
                    .map((service) => serviceCard(service))
                    .toList()),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            'Daftar service ditambahkan',
            style: TextStyle(fontSize: 20),
          ),
          Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.all(10),
            child: Column(
              children: cartProvider.cartServices
                  .map((e) => cardserviceItem(e))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
