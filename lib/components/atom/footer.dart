import 'package:flutter/material.dart';

class Footer extends StatelessWidget {
  const Footer({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
          border: Border(top: BorderSide(color: Colors.black12))),
      child: child,
    );
  }
}
