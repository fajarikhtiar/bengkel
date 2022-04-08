import 'package:bengkel/models/accesorie_model.dart';
import 'package:bengkel/services/accesorie_service.dart';
import 'package:flutter/material.dart';

class AccesorieProvider with ChangeNotifier {
  late List<AccesorieModel> _accesories;

  List<AccesorieModel> get accesories => _accesories;

  set accesories(List<AccesorieModel> accesorie) {
    _accesories = accesories;
    notifyListeners();
  }

  Future<void> getAccesories() async {
    try {
      List<AccesorieModel> accesories =
          await AccesorieService().getAccesories();
      _accesories = accesories;
    } catch (e) {
      print(e);
    }
  }
}
