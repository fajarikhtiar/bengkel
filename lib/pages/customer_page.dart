import 'package:bengkel/models/customer_model.dart';
import 'package:bengkel/providers/auth_provider.dart';
import 'package:bengkel/providers/customer_provider.dart';
import 'package:bengkel/services/customer_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomerPage extends StatelessWidget {
  const CustomerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);

    Widget customerCard(CustomerModel customer) {
      return Container(
        padding: EdgeInsets.all(8),
        margin: EdgeInsets.all(8),
        color: Colors.blueAccent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Text(customer.name),
                SizedBox(
                  height: 10,
                ),
                Text(customer.phone),
              ],
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/edit-customer',
                        arguments: customer);
                  },
                  icon: Icon(
                    Icons.edit,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('List Pelanggan'),
      ),
      body: ListView(
        children: [
          ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/add-customer');
              },
              child: Text('Tambah Pelanggan')),
          FutureBuilder<List<CustomerModel>>(
              future: CustomerService().getCustomers(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text('Error : ${snapshot.error}'),
                  );
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return customerCard(snapshot.data![index]);
                      });
                }
              }),
        ],
      ),
    );
  }
}
