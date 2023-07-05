import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_store/components/atom/footer.dart';
import 'package:my_store/components/molecule/wishlist_button.dart';
import 'package:my_store/components/organism/common_header.dart';
import 'package:my_store/components/template/screen_template.dart';
import 'package:my_store/controllers/product_controller.dart';
import 'package:my_store/domain/models/product.dart';
import 'package:my_store/helpers.dart';

class ProductDetail extends StatelessWidget {
  const ProductDetail({super.key});

  @override
  Widget build(BuildContext context) {
    final ProductModel data = Get.arguments;
    final controller = Get.find<ProductController>();

    return ScreenTemplate(
        header: const CommonHeader(),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(10),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Hero(
                            tag: "thumbnail-${data.id}",
                            child: Image.network(
                              data.image!,
                              width: double.infinity,
                              fit: BoxFit.contain,
                            ),
                          )),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  data.title!,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 5),
                                Text(Helpers.parseMoney(data.price!),
                                    style: const TextStyle(fontSize: 18)),
                              ],
                            ),
                          ),
                          const SizedBox(width: 10),
                          Obx(() {
                            final stateData = controller.data
                                .where((e) => data.id == e.id)
                                .first;

                            return WishlistButton(
                                width: 30,
                                height: 30,
                                isWishlited: stateData.wishlisted,
                                onTap: () => controller.addToWishlist(data));
                          })
                        ],
                      ),
                      const SizedBox(height: 15),
                      const Text(
                        "Description",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        data.description!,
                        style:
                            const TextStyle(color: Colors.black54, height: 1.5),
                      ),
                    ]),
              ),
            ),
            Footer(
                child: Row(
              children: [
                Expanded(
                    child: ElevatedButton(
                        onPressed: () => controller.order(data),
                        child: const Text("Buy"))),
                const SizedBox(width: 10),
                Expanded(
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFD2E4FF),
                        ),
                        onPressed: () => controller.addToCart(data),
                        child: const Text("Add to Cart",
                            style: TextStyle(color: Color(0xFF4A8CEF))))),
              ],
            ))
          ],
        ));
  }
}
