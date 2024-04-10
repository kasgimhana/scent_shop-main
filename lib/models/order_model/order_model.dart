import 'package:scent_shop/models/product_model/product_model.dart';

class OrderModel {
  OrderModel({
    required this.totalprice,
    required this.orderId,
    required this.payment,
    required this.products,
    required this.status,
  });
  String payment;
  String status;
  List<ProductModel> products;
  String orderId;
  double totalprice;

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    List<dynamic> productMap = json["products"];
    return OrderModel(
        totalprice: json["totalprice"],
        orderId: json["orderId"],
        payment: productMap.map((e) => ProductModel.fromJson(e)).toString(),
        products: json["product"],
        status: json["status"]);
  }
}
