import 'dart:convert';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';

class Helpers {
  static String parseMoney(num currency) {
    return "\$${NumberFormat("#,###").format(currency)}";
  }

  static Future<T> runDBQueries<T>(
      Future<T> Function(Database txn) transactions) async {
    var databasesPath = await getDatabasesPath();
    String path = "$databasesPath/store.db";

    Database database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(
          'CREATE TABLE wishlist (id INTEGER PRIMARY KEY, product_id VARCHAR(36), data TEXT)');
      await db.execute(
          'CREATE TABLE cart (id INTEGER PRIMARY KEY, product_id VARCHAR(36), data TEXT)');
      await db.execute(
          'CREATE TABLE transactions (id INTEGER PRIMARY KEY, products LONGTEXT, createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP)');
    });

    return await transactions(database);
  }

  static String encodeStoredData(dynamic data) {
    return base64Encode(utf8.encode(jsonEncode(data)));
  }

  static dynamic decodeStoredData(dynamic data) {
    return jsonDecode(utf8.decode(base64Decode(data)));
  }

  static void showSnackBar(String message) {
    Get.showSnackbar(GetSnackBar(
      message: message,
      duration: const Duration(seconds: 2),
      animationDuration: const Duration(milliseconds: 300),
    ));
  }
}
