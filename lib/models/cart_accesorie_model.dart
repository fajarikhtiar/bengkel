import 'package:bengkel/models/accesorie_model.dart';

class CartAccesorieModel {
  late int id;
  late int customerId;
  late int transactionId;
  late int accesorieId;
  late int qtyAccesorie;
  late AccesorieModel accesorie;

  CartAccesorieModel({
    required this.id,
    required this.accesorie,
    required this.qtyAccesorie,
  });

  CartAccesorieModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerId = json['customer_id'];
    transactionId = json['transaction_id'];
    accesorieId = json['accesorie_id'];
    qtyAccesorie = json['qty_accesorie'];
    accesorie = AccesorieModel.fromJson(json['accesorie']);
  }
}
