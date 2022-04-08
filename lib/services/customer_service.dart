import 'dart:convert';
import 'package:bengkel/models/customer_model.dart';
import 'package:http/http.dart' as http;

class CustomerService {
  static String baseUrl = '192.168.43.188:8000';

  Future<List<CustomerModel>> getCustomers() async {
    var url = Uri.http(baseUrl, 'api/customers');
    var headers = {
      'content-type': 'application/json',
    };
    var response = await http.get(url, headers: headers);
    print(response.body);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];

      List<CustomerModel> customers = [];

      for (var item in data) {
        customers.add(CustomerModel.fromJson(item));
      }
      return customers;
    } else {
      throw Exception('Gagal get Customers!');
    }
  }

  Future<bool> add({
    required String name,
    required String phone,
    required String token,
  }) async {
    var url = Uri.http(baseUrl, 'api/customer');
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
    var url = Uri.http(baseUrl, 'api/customer/$id');
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
}
