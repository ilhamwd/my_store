import 'package:get/get.dart';
import 'package:my_store/domain/models/transaction.dart';
import 'package:my_store/domain/repository/transaction.dart';
import 'package:my_store/helpers.dart';
import 'package:my_store/routes.dart';

import '../domain/models/product.dart';

class TransactionController extends GetxController {
  final repository = TransactionRepository();
  final data = <TransactionModel>[].obs;

  order(List<ProductModel> products) async {
    await repository.addTransaction(TransactionModel(products));

    data.value = await repository.getTransactions();

    Helpers.showSnackBar("Successfully ordered item(s)");
    Get
      ..back()
      ..toNamed(Routes.home);
  }

  @override
  void onInit() {
    super.onInit();

    repository.getTransactions().then((value) => data.value = value);
  }
}
