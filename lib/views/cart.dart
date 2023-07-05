import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:input_quantity/input_quantity.dart';
import 'package:my_store/components/atom/footer.dart';
import 'package:my_store/components/organism/header_with_back.dart';
import 'package:my_store/components/template/screen_template.dart';
import 'package:my_store/controllers/product_controller.dart';
import 'package:my_store/helpers.dart';
import 'package:my_store/routes.dart';

class Cart extends GetView<ProductController> {
  const Cart({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenTemplate(
      header: const HeaderWithBack(title: "Cart"),
      child: Obx(() {
        return Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(vertical: 15),
                children: controller.cart.map((e) {
                  return InkWell(
                    onTap: () =>
                        Get.toNamed(Routes.productDetail, arguments: e),
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Hero(
                            tag: "thumbnail-${e.id}",
                            child: Image.network(
                              e.image!,
                              width: 90,
                            ),
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
                                style: const TextStyle(fontSize: 16),
                              ),
                              const SizedBox(height: 5),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    Helpers.parseMoney(e.price!),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        fontSize: 23,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                    "x${e.qty}",
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              InputQty(
                                  initVal: e.qty,
                                  onQtyChanged: (num? value) =>
                                      controller.updateCartQty(
                                          e, value?.toInt() ?? e.qty))
                            ],
                          ))
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            Footer(
                child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Total"),
                      const SizedBox(height: 3),
                      Text(
                          Helpers.parseMoney(controller.cart.isEmpty
                              ? 0
                              : controller.cart
                                  .map(
                                      (element) => element.qty * element.price!)
                                  .reduce((previousValue, element) =>
                                      previousValue + element)),
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                    onPressed: () => Get.toNamed(Routes.checkout),
                    child: const Text("Checkout"))
              ],
            ))
          ],
        );
      }),
    );
  }
}
