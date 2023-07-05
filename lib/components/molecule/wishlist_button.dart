import 'package:flutter/material.dart';
import 'package:my_store/components/atom/svg_button.dart';

class WishlistButton extends StatelessWidget {
  const WishlistButton(
      {super.key,
      this.isWishlited = false,
      this.onTap,
      this.width,
      this.height});

  final bool isWishlited;
  final void Function()? onTap;
  final double? width, height;

  @override
  Widget build(BuildContext context) {
    return SVGButton(
        width: width,
        height: height,
        svgPath: isWishlited ? 'ic-heart-filled.svg' : 'ic-heart-outlined.svg',
        onTap: onTap);
  }
}
