import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SVGButton extends StatelessWidget {
  const SVGButton(
      {super.key,
      this.onTap,
      required this.svgPath,
      this.width,
      this.height,
      this.showTick = false});

  final void Function()? onTap;
  final String svgPath;
  final double? width, height;
  final bool showTick;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Stack(
        children: [
          SvgPicture.asset("assets/svg/$svgPath",
              width: width ?? 20, height: height ?? 20),
          if (showTick)
            Positioned(
                top: 0,
                right: 0,
                child: Container(
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: Colors.red),
                    width: 10,
                    height: 10)),
        ],
      ),
    );
  }
}
