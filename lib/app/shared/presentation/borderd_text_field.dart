import 'package:flutter/material.dart';
import "package:flutter_screenutil/flutter_screenutil.dart";

class BorderdTextField extends StatelessWidget {
  final String labelText;
  final String? errorText;
  final EdgeInsetsGeometry? contentPadding;
  final double? borderRadius;
  final String? Function(String?) validator;
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  const BorderdTextField({
    Key? key,
    required this.labelText,
    this.controller,
    this.contentPadding,
    required this.validator,
    this.onChanged,
    this.borderRadius,
    this.errorText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      onChanged: onChanged,
      controller: controller,
      decoration: InputDecoration(
        errorText: errorText,
        contentPadding: contentPadding ?? EdgeInsets.zero,
        labelText: labelText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius?.r ?? 0),
        ),
      ),
    );
  }
}
