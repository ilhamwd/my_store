import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_store/components/organism/common_header.dart';
import 'package:my_store/components/organism/product_grid_item.dart';
import 'package:my_store/components/template/screen_template.dart';
import 'package:my_store/controllers/product_controller.dart';

class Home extends GetView<ProductController> {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenTemplate(
      header: const CommonHeader(),
      child: Obx(() {
        return CustomScrollView(
          slivers: [
            SliverList(
                delegate: SliverChildListDelegate([
              const SizedBox(height: 10),
              const Text("Discover",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10)
            ])),
            SliverGrid.count(
              crossAxisCount: 2,
              childAspectRatio: 1 / 1.55,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              children: controller.data
                  .map((element) => ProductGridItem(data: element))
                  .toList(),
            )
          ],
        );
      }),
    );
  }
}
