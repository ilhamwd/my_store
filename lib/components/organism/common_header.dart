import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_store/components/atom/store_logo.dart';
import 'package:my_store/components/atom/svg_button.dart';
import 'package:my_store/controllers/product_controller.dart';
import 'package:my_store/routes.dart';

class CommonHeader extends GetView<ProductController> {
  const CommonHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const StoreLogo(width: 70),
        const Expanded(child: SizedBox()),
        Obx(() {
          return Row(
            children: [
              SVGButton(
                  showTick: controller.wishlist.isNotEmpty,
                  svgPath: "ic-heart-outlined.svg",
                  onTap: () => Get.toNamed(Routes.wishlist)),
              const SizedBox(width: 15),
              SVGButton(
                  showTick: controller.cart.isNotEmpty,
                  svgPath: "ic-cart.svg",
                  onTap: () => Get.toNamed(Routes.cart)),
              const SizedBox(width: 15),
              SVGButton(
                  svgPath: "ic-history.svg",
                  onTap: () => Get.toNamed(Routes.transactions)),
            ],
          );
        }),
      ],
    );
  }
}
