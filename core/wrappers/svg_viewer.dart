import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SvgViewer extends StatelessWidget {
  final String assetName;
  final double height;
  final double width;
  final Color? color;
  final BoxFit fit;
  final VoidCallback? onTap;

  const SvgViewer({
    super.key,
    required this.assetName,
    this.height = 24.0,
    this.width = 24.0,
    this.color,
    this.fit = BoxFit.contain,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SvgPicture.asset(
        assetName,
        width: width,
        height: height,
        fit: fit,
        colorFilter:
        color != null ? ColorFilter.mode(color!, BlendMode.srcIn) : null,
      ),
    );
  }
}