import 'package:my_store/domain/models/transaction.dart';
import 'package:my_store/domain/use_cases/transaction.dart';

import '../../helpers.dart';

class TransactionRepository extends TransactionUseCases {
  @override
  Future<List<TransactionModel>> getTransactions() async {
    return await Helpers.runDBQueries<List<TransactionModel>>((txn) async {
      final rawData = await txn.rawQuery("SELECT * FROM transactions");
      return rawData.map((e) {
        final transactionRawData = {
          ...e,
          "products": Helpers.decodeStoredData(e['products'])
        };

        return TransactionModel.fromJson(transactionRawData);
      }).toList();
    });
  }

  @override
  Future<void> addTransaction(TransactionModel data) {
    return Helpers.runDBQueries<void>((txn) async {
      await txn.rawQuery("DELETE FROM cart");
      await txn.rawQuery(
          "INSERT INTO transactions (products) VALUES ('${Helpers.encodeStoredData(data.products)}')");
    });
  }
}
