import 'package:bengkel/providers/auth_provider.dart';
import 'package:bengkel/providers/customer_provider.dart';
import 'package:bengkel/services/customer_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddCustomer extends StatelessWidget {
  AddCustomer({Key? key}) : super(key: key);

  TextEditingController phoneController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    CustomerProvider customerProvider = Provider.of<CustomerProvider>(context);
    handleAddCustomer() async {
      if (await CustomerService().add(
        name: nameController.text,
        phone: phoneController.text,
        token: authProvider.user.token,
      )) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.blue,
            content: Text(
              'Berhasil Tambah Customer !',
              textAlign: TextAlign.center,
            ),
          ),
        );
        Navigator.pushReplacementNamed(context, '/customer');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            content: Text(
              'Gagal Tambah Customer !',
              textAlign: TextAlign.center,
            ),
          ),
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah Customer'),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          TextFormField(
            controller: nameController,
            decoration: InputDecoration(
              prefix: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Icon(Icons.person)),
              hintText: 'Customer Name',
            ),
          ),
          SizedBox(
            height: 20,
          ),
          TextFormField(
            controller: phoneController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              prefix: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Icon(Icons.phone),
              ),
              hintText: 'Customer Phone Number',
            ),
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: handleAddCustomer,
            child: Text('Tambah Pelanggan'),
          ),
        ],
      ),
    );
  }
}
