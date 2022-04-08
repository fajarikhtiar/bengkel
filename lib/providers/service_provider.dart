import 'package:bengkel/models/service_model.dart';
import 'package:bengkel/services/service_service.dart';
import 'package:flutter/material.dart';

class ServiceProvider with ChangeNotifier {
  late List<ServiceModel> _services;

  List<ServiceModel> get services => _services;

  set services(List<ServiceModel> service) {
    _services = services;
    notifyListeners();
  }

  Future<void> getServices() async {
    try {
      List<ServiceModel> services = await ServiceService().getServices();
      _services = services;
    } catch (e) {
      print(e);
    }
  }
}
