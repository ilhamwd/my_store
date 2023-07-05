import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_store/components/molecule/wishlist_button.dart';
import 'package:my_store/components/organism/header_with_back.dart';
import 'package:my_store/components/template/screen_template.dart';
import 'package:my_store/controllers/product_controller.dart';
import 'package:my_store/helpers.dart';
import 'package:my_store/routes.dart';

class Wishlist extends GetView<ProductController> {
  const Wishlist({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenTemplate(
      header: const HeaderWithBack(title: "Wishlist"),
      child: Obx(() {
        return ListView(
          padding: const EdgeInsets.symmetric(vertical: 15),
          children: controller.wishlist.map((e) {
            return InkWell(
              onTap: () => Get.toNamed(Routes.productDetail, arguments: e),
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
                        height: 90,
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
                        Text(
                          Helpers.parseMoney(e.price!),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ],
                    )),
                    const SizedBox(width: 10),
                    WishlistButton(
                      isWishlited: true,
                      onTap: () => controller.addToWishlist(e),
                    )
                  ],
                ),
              ),
            );
          }).toList(),
        );
      }),
    );
  }
}
