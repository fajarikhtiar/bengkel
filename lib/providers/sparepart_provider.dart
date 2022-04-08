import 'package:bengkel/models/sparepart_model.dart';
import 'package:bengkel/services/sparepart_service.dart';
import 'package:flutter/material.dart';

class SparepartProvider with ChangeNotifier {
  late List<SparepartModel> _spareparts;

  List<SparepartModel> get spareparts => _spareparts;

  set spareparts(List<SparepartModel> sparepart) {
    _spareparts = spareparts;
    notifyListeners();
  }

  Future<void> getSpareparts() async {
    try {
      List<SparepartModel> spareparts =
          await SparepartService().getSpareparts();
      _spareparts = spareparts;
    } catch (e) {
      print(e);
    }
  }
}
