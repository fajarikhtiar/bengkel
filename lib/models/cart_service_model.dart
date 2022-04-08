import 'package:bengkel/models/service_model.dart';

class CartServiceModel {
  late int id;
  late int customerId;
  late int transactionId;
  late int serviceId;
  late int qtyService;
  late ServiceModel service;

  CartServiceModel({
    required this.id,
    required this.service,
    required this.qtyService,
  });

  CartServiceModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerId = json['customer_id'];
    transactionId = json['transaction_id'];
    serviceId = json['service_id'];
    qtyService = json['qty_service'];
    service = ServiceModel.fromJson(json['service']);
  }
}
