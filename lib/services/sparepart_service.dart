import 'dart:convert';
import 'package:bengkel/models/sparepart_model.dart';
import 'package:http/http.dart' as http;

class SparepartService {
  static String baseUrl = '192.168.43.188:8000';

  Future<List<SparepartModel>> getSpareparts() async {
    var url = Uri.http(baseUrl, 'api/spareparts');
    var headers = {
      'content-type': 'application/json',
    };
    var response = await http.get(url, headers: headers);
    print(response.body);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];

      List<SparepartModel> spareparts = [];

      for (var item in data) {
        spareparts.add(SparepartModel.fromJson(item));
      }
      return spareparts;
    } else {
      throw Exception('Gagal get spareparts!');
    }
  }
}
