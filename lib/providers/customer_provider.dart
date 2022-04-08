import 'dart:collection';

import 'package:bengkel/models/customer_model.dart';
import 'package:bengkel/services/customer_service.dart';
import 'package:flutter/cupertino.dart';

class CustomerProvider with ChangeNotifier {
  late List<CustomerModel> _customers;

  List<CustomerModel> get customers => _customers;

  set customers(List<CustomerModel> customer) {
    _customers = customers;
    notifyListeners();
  }

  Future<void> getCustomers() async {
    try {
      List<CustomerModel> customers = await CustomerService().getCustomers();
      _customers = customers;
    } catch (e) {
      print(e);
    }
  }

  late CustomerModel _selectedItem;

  CustomerModel get selectedItem => _selectedItem;

  set selectedItem(CustomerModel selectedItem) {
    _selectedItem = selectedItem;
    notifyListeners();
  }
}
