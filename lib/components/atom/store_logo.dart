import 'package:flutter/material.dart';

class StoreLogo extends StatelessWidget {
  const StoreLogo({super.key, this.width, this.height});

  final double? width, height;

  @override
  Widget build(BuildContext context) {
    return Image.asset("assets/img/logo.png",
        width: width ?? 50, height: height ?? 50);
  }
}
