import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FigtreeText extends StatelessWidget {
  final String text;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? color;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  final int? maxLines;
  final double? letterSpacing;
  final double? height;

  const FigtreeText({
    super.key,
    required this.text,
    this.fontSize,
    this.fontWeight,
    this.color,
    this.textAlign,
    this.overflow,
    this.maxLines,
    this.letterSpacing,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines,
      style: GoogleFonts.figtree(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color ?? Colors.white,
        letterSpacing: letterSpacing,
        height: height,
      ),
    );
  }
}