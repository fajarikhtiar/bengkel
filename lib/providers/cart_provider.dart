import 'package:bengkel/models/accesorie_model.dart';
import 'package:bengkel/models/cart_accesorie_model.dart';
import 'package:bengkel/models/cart_service_model.dart';
import 'package:bengkel/models/cart_sparepart_model.dart';
import 'package:bengkel/models/customer_model.dart';
import 'package:bengkel/models/service_model.dart';
import 'package:bengkel/models/sparepart_model.dart';
import 'package:flutter/material.dart';

class CartProvider with ChangeNotifier {
  List<CartSparepartModel> _cartSpareparts = [];
  List<CartAccesorieModel> _cartAccesories = [];
  List<CartServiceModel> _cartServices = [];
  late CustomerModel _customer;

  List<CartSparepartModel> get cartSpareparts => _cartSpareparts;
  List<CartAccesorieModel> get cartAccesories => _cartAccesories;
  List<CartServiceModel> get cartServices => _cartServices;
  CustomerModel get customer => _customer;

  set customer(CustomerModel customer) {
    _customer = customer;
    notifyListeners();
  }

  set cartSpareparts(List<CartSparepartModel> cartSpareparts) {
    _cartSpareparts = cartSpareparts;
    notifyListeners();
  }

  set cartAccesories(List<CartAccesorieModel> cartAccesories) {
    _cartAccesories = cartAccesories;
    notifyListeners();
  }

  set cartServices(List<CartServiceModel> cartServices) {
    _cartServices = cartServices;
    notifyListeners();
  }

  addSparepart(SparepartModel sparepart) {
    if (sparepartExist(sparepart)) {
      int index = _cartSpareparts
          .indexWhere((element) => element.sparepart.id == sparepart.id);
      _cartSpareparts[index].qtySparepart++;
    } else {
      _cartSpareparts.add(CartSparepartModel(
        id: _cartSpareparts.length,
        sparepart: sparepart,
        qtySparepart: 1,
      ));
    }
    notifyListeners();
  }

  addAccesorie(AccesorieModel accesorie) {
    if (accesorieExist(accesorie)) {
      int index = _cartAccesories
          .indexWhere((element) => element.accesorie.id == accesorie.id);
      _cartAccesories[index].qtyAccesorie++;
    } else {
      _cartAccesories.add(CartAccesorieModel(
        id: _cartAccesories.length,
        accesorie: accesorie,
        qtyAccesorie: 1,
      ));
    }
    notifyListeners();
  }

  addservice(ServiceModel service) {
    if (serviceExist(service)) {
      int index = _cartServices
          .indexWhere((element) => element.service.id == service.id);
      _cartServices[index].qtyService++;
    } else {
      _cartServices.add(CartServiceModel(
        id: _cartServices.length,
        service: service,
        qtyService: 1,
      ));
    }
    notifyListeners();
  }

  removeCart(int id) {
    _cartSpareparts.removeWhere((element) => element.id == id);
    notifyListeners();
  }

  addQuantity(int id, String type) {
    if (type == 'sparepart') {
      int index = _cartSpareparts.indexWhere((element) => element.id == id);
      _cartSpareparts[index].qtySparepart++;
    }
    if (type == 'accesorie') {
      int index = _cartAccesories.indexWhere((element) => element.id == id);
      _cartAccesories[index].qtyAccesorie++;
    }
    if (type == 'service') {
      int index = _cartServices.indexWhere((element) => element.id == id);
      _cartServices[index].qtyService++;
    }
    notifyListeners();
  }

  reduceQuantity(int id, String type) {
    if (type == 'sparepart') {
      int index = _cartSpareparts.indexWhere((element) => element.id == id);
      _cartSpareparts[index].qtySparepart--;
      if (_cartSpareparts[index].qtySparepart == 0) {
        _cartSpareparts.removeAt(index);
      }
    }
    if (type == 'accesorie') {
      int index = _cartAccesories.indexWhere((element) => element.id == id);
      _cartAccesories[index].qtyAccesorie--;
      if (_cartAccesories[index].qtyAccesorie == 0) {
        _cartAccesories.removeAt(index);
      }
    }
    if (type == 'service') {
      int index = _cartServices.indexWhere((element) => element.id == id);
      _cartServices[index].qtyService--;
      if (_cartServices[index].qtyService == 0) {
        _cartServices.removeAt(index);
      }
    }
    notifyListeners();
  }

  totalItem() {
    int total = 0;
    for (var item in _cartSpareparts) {
      total += item.qtySparepart;
    }
    return total;
  }

  totalSparepartPrice() {
    double total = 0;
    for (var item in _cartSpareparts) {
      total += (item.qtySparepart * item.sparepart.price);
    }
    return total;
  }

  totalAccesoriePrice() {
    double total = 0;
    for (var item in _cartAccesories) {
      total += (item.qtyAccesorie * item.accesorie.price);
    }
    return total;
  }

  totalServicePrice() {
    double total = 0;
    for (var item in _cartServices) {
      total += (item.qtyService * item.service.price);
    }
    return total;
  }

  totalPrice(double totalSparepartPrice, double totalAccesoriePrice,
      double totalServicePrice) {
    double total =
        totalSparepartPrice + totalAccesoriePrice + totalServicePrice;

    return total;
  }

  bool sparepartExist(SparepartModel sparepart) {
    if (_cartSpareparts
            .indexWhere((element) => element.sparepart.id == sparepart.id) ==
        -1) {
      print('false');
      return false;
    } else {
      print('true');
      return true;
    }
  }

  bool accesorieExist(AccesorieModel accesorie) {
    if (_cartAccesories
            .indexWhere((element) => element.accesorie.id == accesorie.id) ==
        -1) {
      print('false');
      return false;
    } else {
      print('true');
      return true;
    }
  }

  bool serviceExist(ServiceModel service) {
    if (_cartServices
            .indexWhere((element) => element.service.id == service.id) ==
        -1) {
      print('false');
      return false;
    } else {
      print('true');
      return true;
    }
  }
}
