import 'package:bengkel/models/customer_model.dart';
import 'package:bengkel/providers/auth_provider.dart';
import 'package:bengkel/providers/customer_provider.dart';
import 'package:bengkel/services/customer_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditCustomerPage extends StatelessWidget {
  EditCustomerPage({Key? key}) : super(key: key);

  TextEditingController phoneController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    CustomerModel customer =
        ModalRoute.of(context)!.settings.arguments as CustomerModel;
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    CustomerProvider customerProvider = Provider.of<CustomerProvider>(context);
    phoneController.text = customer.phone;
    nameController.text = customer.name;

    handleEditCustomer() async {
      if (await CustomerService().edit(
        name: nameController.text,
        phone: phoneController.text,
        token: authProvider.user.token,
        id: customer.id.toString(),
      )) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.blue,
            content: Text(
              'Berhasil Edit Customer !',
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
              'Gagal Edit Customer !',
              textAlign: TextAlign.center,
            ),
          ),
        );
      }
    }

    handleDeleteCustomer() async {
      if (await CustomerService().delete(
        token: authProvider.user.token,
        id: customer.id.toString(),
      )) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.blue,
            content: Text(
              'Berhasil Hapus Customer !',
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
              'Gagal Hapus Customer !',
              textAlign: TextAlign.center,
            ),
          ),
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Pelanggan'),
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
            onPressed: handleEditCustomer,
            child: Text('Simpan Perubahan'),
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(primary: Colors.red),
            onPressed: handleDeleteCustomer,
            child: Text('Hapus Customer'),
          ),
        ],
      ),
    );
  }
}
