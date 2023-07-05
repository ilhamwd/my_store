import 'package:my_store/domain/models/transaction.dart';

abstract class TransactionUseCases {
  Future<List<TransactionModel>> getTransactions();

  Future<void> addTransaction(TransactionModel data);
}
