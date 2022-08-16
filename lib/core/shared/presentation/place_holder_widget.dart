import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class PlaceHolderWidget extends StatelessWidget {
  final String imagePath;
  final String text;
  final bool shouldShowIndicator;

  const PlaceHolderWidget({
    Key? key,
    required this.imagePath,
    required this.text,
    this.shouldShowIndicator = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (shouldShowIndicator) {
      return const Center(child: CircularProgressIndicator());
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          imagePath,
          fit: BoxFit.cover,
          width: 200.w,
          height: 200.h,
        ),
        Text(
          text,
          style: GoogleFonts.mulish(),
        ),
      ],
    );
  }
}
