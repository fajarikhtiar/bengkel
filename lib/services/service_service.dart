import 'dart:convert';
import 'package:bengkel/models/service_model.dart';
import 'package:bengkel/models/sparepart_model.dart';
import 'package:http/http.dart' as http;

class ServiceService {
  static String baseUrl = '192.168.43.188:8000';

  Future<List<ServiceModel>> getServices() async {
    var url = Uri.http(baseUrl, 'api/services');
    var headers = {
      'content-type': 'application/json',
    };
    var response = await http.get(url, headers: headers);
    print(response.body);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];

      List<ServiceModel> services = [];

      for (var item in data) {
        services.add(ServiceModel.fromJson(item));
      }
      return services;
    } else {
      throw Exception('Gagal get services!');
    }
  }
}
