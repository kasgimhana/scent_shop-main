// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

ProductModel productModelFromJson(String str) =>
    ProductModel.fromJson(json.decode(str));

String ProductModelToJson(ProductModel data) => json.encode(data.toJson());

class ProductModel {
  ProductModel({
    required this.image,
    required this.id,
    required this.isFavourite,
    required this.name,
    required this.price,
    required this.description,
    required this.status,
    required this.qty,
  });
  String image;
  String id;
  bool isFavourite;
  String name;
  double price;
  String description;
  String status;
  int? qty;

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        image: json["image"],
        id: json["id"],
        isFavourite: false,
        name: json["name"],
        qty: json["qty"],
        price: double.parse(json["price"].toString()),
        description: json["description"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "image": image,
        "id": id,
        "name": name,
        "status": status,
        "description": description,
        "price": price,
        "isFavourite": isFavourite,
        "qty": qty,
      };
  ProductModel copyWith({
    int? qty,
  }) =>
      ProductModel(
        image: image,
        id: id,
        isFavourite: isFavourite,
        name: name,
        qty: qty ?? this.qty,
        price: price,
        description: description,
        status: status,
      );
}
