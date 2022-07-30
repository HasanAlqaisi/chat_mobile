import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class GreyTextField extends StatelessWidget {
  final String hint;
  final Icon? icon;
  final TextEditingController? textController;
  final Function(String)? onChanged;

  const GreyTextField({
    Key? key,
    required this.hint,
    this.icon,
    this.textController,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      cursorColor: Colors.grey,
      controller: textController,
      onChanged: onChanged,
      decoration: InputDecoration(
        fillColor: const Color(0xFFF7F7FC),
        filled: true,
        border: InputBorder.none,
        hintText: hint,
        hintStyle: GoogleFonts.mulish(
          color: const Color(0xFFADB5BD),
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
        ),
        prefixIcon: icon,
      ),
    );
  }
}
