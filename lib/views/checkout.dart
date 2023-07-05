import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_store/components/atom/footer.dart';
import 'package:my_store/components/organism/header_with_back.dart';
import 'package:my_store/components/template/screen_template.dart';
import 'package:my_store/controllers/product_controller.dart';
import 'package:my_store/controllers/transaction_controller.dart';
import 'package:my_store/helpers.dart';

class Checkout extends GetView<ProductController> {
  const Checkout({super.key});

  @override
  Widget build(BuildContext context) {
    final transactionController = Get.find<TransactionController>();

    return ScreenTemplate(
      header: const HeaderWithBack(title: "Checkout"),
      child: Obx(() {
        return Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(vertical: 15),
                children: [
                  ...controller.cart.map((e) {
                    return Container(
                      padding: const EdgeInsets.all(15),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.network(
                            e.image!,
                            width: 60,
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                e.title!,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 3),
                              Text(
                                "Quantity: ${e.qty}",
                                style: const TextStyle(
                                    fontSize: 12, color: Colors.black54),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                Helpers.parseMoney(e.price!),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ))
                        ],
                      ),
                    );
                  })
                ],
              ),
            ),
            Footer(
                child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () => transactionController.order(controller.cart),
                  child: const Text("Confirm Order")),
            ))
          ],
        );
      }),
    );
  }
}
