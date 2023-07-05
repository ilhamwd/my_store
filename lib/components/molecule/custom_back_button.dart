import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_store/components/atom/svg_button.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({super.key, this.onTap});

  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return SVGButton(
      svgPath: "ic-back.svg",
      onTap: onTap ?? () => Get.back(),
      width: 25,
      height: 25,
    );
  }
}
