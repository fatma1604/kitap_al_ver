// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextFormField extends StatelessWidget {
  final String labelText;
  final int maxLines;
  final ValueChanged<String> onChanged;
  final String? Function(String?)? validator;

  // ignore: use_super_parameters
  const CustomTextFormField({
    Key? key,
    required this.labelText,
    this.maxLines = 1,
    required this.onChanged,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[210],
        borderRadius: BorderRadius.circular(8.0.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            offset: const Offset(0, 4),
            blurRadius: 8.0,
          ),
        ],
      ),
      child: TextFormField(
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: GoogleFonts.roboto(
            textStyle: TextStyle(
              color: Colors.black54,
              fontSize: 16.sp,
            ),
          ),
          border: const OutlineInputBorder(
            borderSide: BorderSide.none,
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 12.0.h),
        ),
        validator: validator,
        onChanged: onChanged,
        style: GoogleFonts.roboto(
          textStyle: TextStyle(
            color: Colors.black87,
            fontSize: 16.sp,
          ),
        ),
      ),
    );
  }
}
