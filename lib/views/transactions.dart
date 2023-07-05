import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_store/components/organism/header_with_back.dart';
import 'package:my_store/components/template/screen_template.dart';
import 'package:my_store/controllers/transaction_controller.dart';
import 'package:my_store/helpers.dart';
import 'package:my_store/routes.dart';

class TransactionsHistory extends GetView<TransactionController> {
  const TransactionsHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenTemplate(
      header: const HeaderWithBack(title: "Transactions History"),
      child: Obx(() {
        return ListView(
          padding: const EdgeInsets.symmetric(vertical: 15),
          children: controller.data.map((e) {
            final date = DateTime.parse(e.createdAt!);

            return Container(
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(blurRadius: 30, color: Colors.black.withOpacity(.1))
              ], color: Colors.white, borderRadius: BorderRadius.circular(10)),
              padding: const EdgeInsets.all(20),
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Image.network(
                        e.products!.first.image!,
                        width: 80,
                      ),
                      if (e.products!.length > 1)
                        Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: Text("${e.products!.length - 1} more",
                                style: const TextStyle(color: Colors.black54)))
                    ],
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        date.toString(),
                        style: const TextStyle(
                            fontSize: 12, color: Colors.black45),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        date.millisecondsSinceEpoch.toString(),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 20),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        Helpers.parseMoney(e.products!
                            .map((e) => e.qty * e.price!)
                            .reduce((value, element) => value + element)),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ))
                ],
              ),
            );
          }).toList(),
        );
      }),
    );
  }
}
