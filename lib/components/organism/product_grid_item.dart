import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_store/components/molecule/wishlist_button.dart';
import 'package:my_store/controllers/product_controller.dart';
import 'package:my_store/domain/models/product.dart';
import 'package:my_store/helpers.dart';
import 'package:my_store/routes.dart';

class ProductGridItem extends StatelessWidget {
  const ProductGridItem({super.key, required this.data});

  final ProductModel data;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProductController>();

    return InkWell(
      onTap: () => Get.toNamed(Routes.productDetail, arguments: data),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(blurRadius: 30, color: Colors.black.withOpacity(.08))
            ]),
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Hero(
                tag: "thumbnail-${data.id}",
                child: Image.network(
                  data.image!,
                  height: 150,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(data.title ?? "N/A",
                style: const TextStyle(fontWeight: FontWeight.bold),
                overflow: TextOverflow.ellipsis,
                maxLines: 2),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        const Icon(Icons.star,
                            size: 20, color: Color(0xFFEEB64A)),
                        const SizedBox(width: 5),
                        Text(
                            "${data.rating?.rate ?? 0} (${data.rating?.count ?? 0})",
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                                color: Colors.black87))
                      ]),
                      const SizedBox(height: 10),
                      Text(Helpers.parseMoney(data.price ?? 0),
                          style: const TextStyle(fontSize: 18),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2),
                    ],
                  ),
                ),
                WishlistButton(
                    isWishlited: data.wishlisted,
                    onTap: () => controller.addToWishlist(data))
              ],
            )
          ],
        ),
      ),
    );
  }
}
