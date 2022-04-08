class AccesorieModel {
  late int id;
  late String name;
  late double price;

  AccesorieModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = double.parse(json['price'].toString());
  }
}
