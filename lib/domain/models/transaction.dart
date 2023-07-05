import 'package:my_store/domain/models/product.dart';

class TransactionModel {
  String? createdAt;
  List<ProductModel>? products;

  TransactionModel(this.products);

  TransactionModel.fromJson(Map<String, dynamic> json) {
    createdAt = json['createdAt'];

    if (json['products'] != null) {
      products = <ProductModel>[];
      json['products'].forEach((v) {
        products!.add(ProductModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['createdAt'] = createdAt;

    if (products != null) {
      data['products'] = products!.map((v) => v.toJson()).toList();
    }

    return data;
  }
}
