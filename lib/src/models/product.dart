import 'dart:convert';

Product productFromJson(String str) => Product.fromJson(json.decode(str));

String productToJson(Product data) => json.encode(data.toJson());

class Product {

  int? id;
  String? name;
  String? description;
  String? image1;
  String? image2;
  String? image3;
  DateTime? date_of_expire;
  String? grammage;
  int? category;
  double? price;
  int? amount;
  int? quantity;

  Product({
    this.id,
    this.name,
    this.description,
    this.image1,
    this.image2,
    this.image3,
    this.date_of_expire,
    this.grammage,
    this.category,
    this.price,
    this.amount,
    this.quantity,
  });



  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json['id'],
    name: json['name'],
    description: json['description'],
    price: double.parse(json['price'].toString()),
    image1: json['image1'],
    image2: json['image2'],
    image3: json['image3'],
    date_of_expire: DateTime.parse(json['date_of_expire']),
    amount: json['amount'],
    grammage: json['grammage'],
    quantity: json["quantity"],
    category: json["category"]
  );



  /*
  static List<Product> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => Product.fromJson(json)).toList();
  }

   */
  static List<Product> fromJsonList(List<dynamic> jsonList) {
    List<Product> toList = [];
    jsonList.forEach((item) {
      Product product = Product.fromJson(item);
      toList.add(product);
    });
    return toList;
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "image1": image1,
    "image2": image2,
    "image3": image3,
    "grammage" : grammage,
    'date_of_expire': date_of_expire?.toIso8601String(),
    "category": category,
    "price": price,
    "amount" : amount,
    "quantity": quantity,
  };
}
