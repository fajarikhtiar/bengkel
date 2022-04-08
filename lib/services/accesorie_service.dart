import 'dart:convert';
import 'package:bengkel/models/accesorie_model.dart';
import 'package:http/http.dart' as http;

class AccesorieService {
  static String baseUrl = '192.168.43.188:8000';

  Future<List<AccesorieModel>> getAccesories() async {
    var url = Uri.http(baseUrl, 'api/accesories');
    var headers = {
      'content-type': 'application/json',
    };
    var response = await http.get(url, headers: headers);
    print(response.body);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];

      List<AccesorieModel> accesories = [];

      for (var item in data) {
        accesories.add(AccesorieModel.fromJson(item));
      }
      return accesories;
    } else {
      throw Exception('Gagal get accesories!');
    }
  }
}
