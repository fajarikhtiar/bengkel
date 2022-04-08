class ServiceModel {
  late int id;
  late String name;
  late double price;

  ServiceModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = double.parse(json['price'].toString());
  }
}
