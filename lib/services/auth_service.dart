import 'dart:convert';
import 'package:bengkel/models/user_model.dart';
import 'package:http/http.dart' as http;

class AuthService {
  static String baseUrl = '192.168.43.188:8000';

  Future<UserModel> register({
    required String name,
    required String email,
    required String password,
  }) async {
    var url = Uri.http(baseUrl, 'api/register');
    var headers = {'content-type': 'application/json'};
    var body = jsonEncode({'name': name, 'email': email, 'password': password});
    var response = await http.post(
      url,
      headers: headers,
      body: body,
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      print(data);
      UserModel user = UserModel.fromJson(data['user']);
      print(user);
      user.token = 'Bearer ' + data['access_token'];
      return user;
    } else {
      throw Exception('Gagal register');
    }
  }

  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    var url = Uri.http(baseUrl, 'api/login');
    var headers = {'content-type': 'application/json'};
    var body = jsonEncode({'email': email, 'password': password});
    var response = await http.post(
      url,
      headers: headers,
      body: body,
    );
    print(response.body);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      UserModel user = UserModel.fromJson(data['user']);
      user.token = 'Bearer ' + data['access_token'];
      return user;
    } else {
      throw Exception('Gagal login');
    }
  }
}
