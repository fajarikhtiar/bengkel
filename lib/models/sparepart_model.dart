class SparepartModel {
  late int id;
  late String name;
  late double price;

  SparepartModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'] ?? "";
    print('sukses atas');
    price = double.parse(json['price'].toString());
    print('sukses');
  }
}
