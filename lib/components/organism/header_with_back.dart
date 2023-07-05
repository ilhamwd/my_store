import 'package:flutter/material.dart';
import 'package:my_store/components/molecule/custom_back_button.dart';

class HeaderWithBack extends StatelessWidget {
  const HeaderWithBack({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const CustomBackButton(),
        const SizedBox(width: 15),
        Text(title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      ],
    );
  }
}
