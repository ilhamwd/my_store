import 'package:get/get.dart';
import 'package:my_store/controllers/product_controller.dart';
import 'package:my_store/controllers/transaction_controller.dart';

class CheckoutBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProductController());
    Get.lazyPut(() => TransactionController());
  }
}
