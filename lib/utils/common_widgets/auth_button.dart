import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthButton extends StatelessWidget {
  final String text;
  final bool showIndicator;
  final double? fontSize;
  final FontWeight? fontWeight;
  final double borderRadius;
  final EdgeInsets? padding;
  final Color? primary;
  final Color? onSurface;
  final Color? surfaceTintColor;

  final Function()? onPressed;

  const AuthButton({
    Key? key,
    required this.text,
    this.onPressed,
    this.showIndicator = false,
    required this.borderRadius,
    this.padding,
    this.primary,
    this.onSurface,
    this.surfaceTintColor,
    this.fontSize,
    this.fontWeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        padding: padding,
        primary: primary,
        onSurface: onSurface,
        surfaceTintColor: onSurface,
      ),
      onPressed: onPressed,
      child: showIndicator
          ? const CircularProgressIndicator(strokeWidth: 2)
          : Text(
              text,
              style: GoogleFonts.outfit(
                fontWeight: fontWeight,
                fontSize: fontSize,
                color: Colors.white,
              ),
            ),
    );
  }
}
