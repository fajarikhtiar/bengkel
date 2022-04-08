import 'package:bengkel/models/cart_accesorie_model.dart';
import 'package:bengkel/models/cart_service_model.dart';
import 'package:bengkel/models/cart_sparepart_model.dart';
import 'package:bengkel/providers/auth_provider.dart';
import 'package:bengkel/providers/cart_provider.dart';
import 'package:bengkel/providers/transaction_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CheckoutPage extends StatelessWidget {
  const CheckoutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CartProvider cartProvider = Provider.of<CartProvider>(context);
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    TransactionProvider transactionProvider =
        Provider.of<TransactionProvider>(context);
    String IdTransaction = ModalRoute.of(context)!.settings.arguments as String;

    Widget customerDetail() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Detail Pelanggan'),
          Divider(),
          Text('Nama pelanggan : ${cartProvider.customer.name}'),
          SizedBox(
            height: 8,
          ),
          Text('Nomor Handphone : ${cartProvider.customer.phone}'),
        ],
      );
    }

    Widget cartSparepartCard(CartSparepartModel sparepart) {
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(sparepart.sparepart.name),
              Text('${sparepart.qtySparepart} X ${sparepart.sparepart.price}'),
            ],
          ),
        ],
      );
    }

    Widget sparepartDetail() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Sparepart Detail',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Divider(),
          Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: cartProvider.cartSpareparts
                  .map((sparepart) => cartSparepartCard(sparepart))
                  .toList()),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    width: 100,
                    child: Divider(),
                  ),
                  Text(' ${cartProvider.totalSparepartPrice()}'),
                ],
              ),
            ],
          ),
        ],
      );
    }

    Widget cartAccesorieCard(CartAccesorieModel Accesorie) {
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(Accesorie.accesorie.name),
              Text('${Accesorie.qtyAccesorie} X ${Accesorie.accesorie.price}'),
            ],
          ),
        ],
      );
    }

    Widget accesorieDetail() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Accesorie Detail',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Divider(),
          Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: cartProvider.cartAccesories
                  .map((Accesorie) => cartAccesorieCard(Accesorie))
                  .toList()),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    width: 100,
                    child: Divider(),
                  ),
                  Text(' ${cartProvider.totalAccesoriePrice()}'),
                ],
              ),
            ],
          ),
        ],
      );
    }

    Widget cartServiceCard(CartServiceModel Service) {
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(Service.service.name),
              Text('${Service.qtyService} X ${Service.service.price}'),
            ],
          ),
        ],
      );
    }

    Widget serviceDetail() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Service Detail',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Divider(),
          Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: cartProvider.cartServices
                  .map((Service) => cartServiceCard(Service))
                  .toList()),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    width: 100,
                    child: Divider(),
                  ),
                  Text(' ${cartProvider.totalServicePrice()}'),
                ],
              ),
            ],
          ),
        ],
      );
    }

    Widget totalPrice() {
      double totalSparepartPrice = cartProvider.totalSparepartPrice();
      double totalAccesoriePrice = cartProvider.totalAccesoriePrice();
      double totalServicePrice = cartProvider.totalServicePrice();
      double total = cartProvider.totalPrice(
          totalSparepartPrice, totalAccesoriePrice, totalServicePrice);
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Total Harga',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(
            '$total',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      );
    }

    handleCheckout() async {
      double totalSparepartPrice = cartProvider.totalSparepartPrice();
      double totalAccesoriePrice = cartProvider.totalAccesoriePrice();
      double totalServicePrice = cartProvider.totalServicePrice();
      if (IdTransaction != '') {
        if (await transactionProvider.editCheckout(
          IdTransaction,
          cartProvider.customer.id.toString(),
          authProvider.user.token,
          cartProvider.cartSpareparts,
          cartProvider.cartAccesories,
          cartProvider.cartServices,
          cartProvider.totalPrice(
              totalSparepartPrice, totalAccesoriePrice, totalServicePrice),
        )) {
          cartProvider.cartSpareparts = [];
          cartProvider.cartAccesories = [];
          cartProvider.cartServices = [];
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.green,
              content: Text(
                'Berhasil Edit Transaksi',
                textAlign: TextAlign.center,
              ),
            ),
          );
          Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.red,
              content: Text(
                'Gagal Edit Transaksi',
                textAlign: TextAlign.center,
              ),
            ),
          );
        }
      } else {
        if (await transactionProvider.checkout(
          cartProvider.customer.id.toString(),
          authProvider.user.token,
          cartProvider.cartSpareparts,
          cartProvider.cartAccesories,
          cartProvider.cartServices,
          cartProvider.totalPrice(
              totalSparepartPrice, totalAccesoriePrice, totalServicePrice),
        )) {
          cartProvider.cartSpareparts = [];
          cartProvider.cartAccesories = [];
          cartProvider.cartServices = [];
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.green,
              content: Text(
                'Berhasil Menambahkan Transaksi',
                textAlign: TextAlign.center,
              ),
            ),
          );
          Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.red,
              content: Text(
                'Gagal Menambahkan Transaksi',
                textAlign: TextAlign.center,
              ),
            ),
          );
        }
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('CheckOut Page'),
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          customerDetail(),
          SizedBox(
            height: 20,
          ),
          sparepartDetail(),
          accesorieDetail(),
          serviceDetail(),
          SizedBox(
            height: 20,
          ),
          Divider(),
          SizedBox(
            height: 20,
          ),
          totalPrice(),
          SizedBox(
            height: 50,
          ),
          ElevatedButton(
            onPressed: handleCheckout,
            child: IdTransaction != ''
                ? Text('Edit Transaksi')
                : Text('Submit Transaksi'),
          ),
        ],
      ),
    );
  }
}
