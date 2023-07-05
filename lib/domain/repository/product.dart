import 'dart:convert';

import 'package:http/http.dart';
import 'package:my_store/domain/models/product.dart';
import 'package:my_store/domain/use_cases/product.dart';
import 'package:my_store/helpers.dart';

class ProductRepository extends ProductUseCases {
  @override
  Future<List<ProductModel>> getProducts() async {
    final req = await get(Uri.parse("https://fakestoreapi.com/products"));
    final res = jsonDecode(req.body) as List<dynamic>;
    final data = res.map((e) => ProductModel.fromJson(e)).toList();

    return data;
  }

  @override
  Future<void> addToCart(ProductModel data) async {
    return await Helpers.runDBQueries<void>((txn) async {
      txn.rawQuery(
          "INSERT INTO cart (data, product_id) VALUES ('${Helpers.encodeStoredData(data.toJson())}', '${data.id}')");
    });
  }

  @override
  Future<void> deleteFromCart(ProductModel data) async {
    return await Helpers.runDBQueries<void>((txn) async {
      txn.rawQuery("DELETE FROM cart WHERE product_id='${data.id}'");
    });
  }

  @override
  Future<List<ProductModel>> getCartItems() async {
    return await Helpers.runDBQueries<List<ProductModel>>((txn) async {
      final rawData = await txn.rawQuery("SELECT * FROM cart");

      return rawData
          .map((e) => ProductModel.fromJson(
              Helpers.decodeStoredData(e['data'] as String)))
          .toList();
    });
  }

  @override
  Future<void> addToWishlist(ProductModel data) async {
    return await Helpers.runDBQueries<void>((txn) async {
      txn.rawQuery(
          "INSERT INTO wishlist (data, product_id) VALUES ('${Helpers.encodeStoredData(data.toJson())}', '${data.id}')");
    });
  }

  @override
  Future<void> deleteFromWishlist(ProductModel data) async {
    return await Helpers.runDBQueries<void>((txn) async {
      txn.rawQuery("DELETE FROM wishlist WHERE product_id='${data.id}'");
    });
  }

  @override
  Future<List<ProductModel>> getWishlistItems() async {
    return await Helpers.runDBQueries<List<ProductModel>>((txn) async {
      final rawData = await txn.rawQuery("SELECT * FROM wishlist");

      return rawData
          .map((e) => ProductModel.fromJson(
              Helpers.decodeStoredData(e['data'] as String)))
          .toList();
    });
  }

  @override
  Future<void> updateCartQty(ProductModel data, int qty) {
    data.qty = qty;

    return Helpers.runDBQueries<void>((txn) async {
      txn.rawQuery(
          "UPDATE cart SET data='${Helpers.encodeStoredData(data.toJson())}' WHERE product_id='${data.id}'");
    });
  }
}
