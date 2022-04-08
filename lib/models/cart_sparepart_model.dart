import 'package:bengkel/models/sparepart_model.dart';

class CartSparepartModel {
  late int id;
  late int customerId;
  late int transactionId;
  late int sparepartId;
  late int qtySparepart;
  late SparepartModel sparepart;

  CartSparepartModel({
    required this.id,
    required this.sparepart,
    required this.qtySparepart,
  });

  CartSparepartModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerId = json['customer_id'];
    transactionId = json['transaction_id'];
    sparepartId = json['sparepart_id'];
    qtySparepart = json['qty_sparepart'];
    sparepart = SparepartModel.fromJson(json['sparepart']);
  }
}
