import 'package:bengkel/models/transaction_model.dart';
import 'package:bengkel/providers/auth_provider.dart';
import 'package:bengkel/services/transaction_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TransactionPage extends StatefulWidget {
  const TransactionPage({Key? key}) : super(key: key);

  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);

    Widget transactionCard(TransactionModel transaction) {
      return Container(
        padding: EdgeInsets.all(12),
        margin: EdgeInsets.all(8),
        color: Colors.blueAccent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('ID Transaksi : ${transaction.id}'),
                SizedBox(
                  height: 10,
                ),
                Text('Nama Pelanggan : ${transaction.customer.name}'),
                SizedBox(
                  height: 10,
                ),
                Text('Total Belanja : ${transaction.totalPrice}'),
              ],
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/transaction-sparepart',
                        arguments: transaction);
                  },
                  icon: Icon(
                    Icons.edit,
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                IconButton(
                  onPressed: () async {
                    await TransactionService().delete(
                        token: authProvider.user.token,
                        id: transaction.id.toString());
                    setState(() {});
                  },
                  icon: Icon(
                    Icons.delete,
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
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, '/add-transaction');
        },
      ),
      appBar: AppBar(
        centerTitle: true,
        title: Text('List Transaksi'),
      ),
      body: ListView(
        children: [
          FutureBuilder<List<TransactionModel>>(
              future: TransactionService().getTransactions(),
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
                      physics: ScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return transactionCard(snapshot.data![index]);
                      });
                }
              }),
        ],
      ),
    );
  }
}
