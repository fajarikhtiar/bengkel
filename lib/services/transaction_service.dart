import 'dart:convert';
import 'package:bengkel/models/cart_accesorie_model.dart';
import 'package:bengkel/models/cart_service_model.dart';
import 'package:bengkel/models/cart_sparepart_model.dart';
import 'package:bengkel/models/transaction_model.dart';
import 'package:http/http.dart' as http;

class TransactionService {
  static String baseUrl = '192.168.43.188:8000';

  Future<List<TransactionModel>> getTransactions() async {
    var url = Uri.http(baseUrl, 'api/transactions');
    var headers = {
      'content-type': 'application/json',
    };
    var response = await http.get(url, headers: headers);
    print(response.body);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];

      List<TransactionModel> transactions = [];

      for (var item in data) {
        transactions.add(TransactionModel.fromJson(item));
      }
      return transactions;
    } else {
      throw Exception('Gagal get transactions!');
    }
  }

  Future<bool> add({
    required String name,
    required String phone,
    required String token,
  }) async {
    var url = Uri.http(baseUrl, 'api/transactions');
    var headers = {
      'content-type': 'application/json',
      'Authorization': token,
    };
    var body = jsonEncode({
      'name': name,
      'phone': phone,
    });
    var response = await http.post(
      url,
      headers: headers,
      body: body,
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> edit({
    required String name,
    required String phone,
    required String token,
    required String id,
  }) async {
    var url = Uri.http(baseUrl, 'api/customer/$id');
    var headers = {
      'content-type': 'application/json',
      'Authorization': token,
    };
    var body = jsonEncode({
      'name': name,
      'phone': phone,
    });
    var response = await http.put(
      url,
      headers: headers,
      body: body,
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> delete({
    required String token,
    required String id,
  }) async {
    var url = Uri.http(baseUrl, 'api/transactions/$id');
    var headers = {
      'content-type': 'application/json',
      'Authorization': token,
    };

    var response = await http.delete(
      url,
      headers: headers,
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> checkout(
    String customerId,
    String token,
    List<CartSparepartModel> cartSpareparts,
    List<CartAccesorieModel> cartAccesories,
    List<CartServiceModel> cartServices,
    double totalPrice,
  ) async {
    var url = Uri.http(baseUrl, 'api/checkout');
    var headers = {
      'content-type': 'application/json',
      'Authorization': token,
    };
    var body = jsonEncode({
      'customer_id': customerId,
      'sparepart_items': cartSpareparts
          .map((cart) => {
                'id': cart.sparepart.id,
                'quantity': cart.qtySparepart,
              })
          .toList(),
      'accesorie_items': cartAccesories
          .map((cart) => {
                'id': cart.accesorie.id,
                'quantity': cart.qtyAccesorie,
              })
          .toList(),
      'service_items': cartServices
          .map((cart) => {
                'id': cart.service.id,
                'quantity': cart.qtyService,
              })
          .toList(),
      'total_price': totalPrice,
    });

    var response = await http.post(url, headers: headers, body: body);

    print(response.body);

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Gagal melakukan checkout!');
    }
  }

  Future<bool> editCheckout(
    String id,
    String customerId,
    String token,
    List<CartSparepartModel> cartSpareparts,
    List<CartAccesorieModel> cartAccesories,
    List<CartServiceModel> cartServices,
    double totalPrice,
  ) async {
    var url = Uri.http(
      baseUrl,
      'api/checkout/$id',
    );
    var headers = {
      'content-type': 'application/json',
      'Authorization': token,
    };
    var body = jsonEncode({
      'customer_id': customerId,
      'sparepart_items': cartSpareparts
          .map((cart) => {
                'id': cart.sparepart.id,
                'quantity': cart.qtySparepart,
              })
          .toList(),
      'accesorie_items': cartAccesories
          .map((cart) => {
                'id': cart.accesorie.id,
                'quantity': cart.qtyAccesorie,
              })
          .toList(),
      'service_items': cartServices
          .map((cart) => {
                'id': cart.service.id,
                'quantity': cart.qtyService,
              })
          .toList(),
      'total_price': totalPrice,
    });

    var response = await http.put(url, headers: headers, body: body);

    print(response.body);

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Gagal edit checkout!');
    }
  }
}
