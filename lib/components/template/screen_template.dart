import 'package:flutter/material.dart';

class ScreenTemplate extends StatelessWidget {
  const ScreenTemplate(
      {super.key, this.header, required this.child, this.padding});

  final Widget? header;
  final Widget child;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Material(
            color: Colors.transparent,
            child: SafeArea(
              child: Padding(
                padding: padding ?? const EdgeInsets.all(15),
                child: Column(
                  children: [
                    if (header != null) header!,
                    Expanded(child: child)
                  ],
                ),
              ),
            )));
  }
}
