import 'package:bengkel/models/accesorie_model.dart';
import 'package:bengkel/models/cart_accesorie_model.dart';
import 'package:bengkel/models/cart_service_model.dart';
import 'package:bengkel/models/cart_sparepart_model.dart';
import 'package:bengkel/models/customer_model.dart';
import 'package:bengkel/models/service_model.dart';
import 'package:bengkel/models/sparepart_model.dart';

class TransactionModel {
  late int id;
  late int customerId;
  late double totalPrice;
  late DateTime createdAt;
  late CustomerModel customer;
  late List<CartSparepartModel> spareparts;
  late List<CartAccesorieModel> accesories;
  late List<CartServiceModel> services;

  TransactionModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerId = json['customer_id'];
    totalPrice = double.parse(json['total_price'].toString());
    createdAt = DateTime.parse(json['created_at']);
    customer = CustomerModel.fromJson(json['customer']);
    spareparts = json['sparepart_items']
        .map<CartSparepartModel>(
            (sparepart) => CartSparepartModel.fromJson(sparepart))
        .toList();
    accesories = json['accesorie_items']
        .map<CartAccesorieModel>(
            (accesorie) => CartAccesorieModel.fromJson(accesorie))
        .toList();
    services = json['service_items']
        .map<CartServiceModel>((service) => CartServiceModel.fromJson(service))
        .toList();
  }
}
