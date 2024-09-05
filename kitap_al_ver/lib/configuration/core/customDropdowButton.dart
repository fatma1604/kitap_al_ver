// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomDropdownButtonFormField extends StatelessWidget {
  final String labelText;
  final String? value;
  final List<String> items;
  final ValueChanged<String?> onChanged;
  final String? Function(String?)? validator;

  // ignore: use_super_parameters
  const CustomDropdownButtonFormField({
    Key? key,
    required this.labelText,
    required this.value,
    required this.items,
    required this.onChanged,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200], // Background color
        borderRadius: BorderRadius.circular(8.0.r), // Rounded corners
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1), // Shadow color
            offset: const Offset(0, 4), // Shadow position
            blurRadius: 8.0, // Shadow blur radius
          ),
        ],
      ),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: GoogleFonts.roboto(
            textStyle: TextStyle(
              color: Colors.black54, // Label color
              fontSize: 16.sp,
            ),
          ),
          border: const OutlineInputBorder(
            borderSide: BorderSide.none, // Hide borders
          ),
          contentPadding:
              EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 12.0.h),
        ),
        value: value,
        items: items.map((item) {
          return DropdownMenuItem(
            value: item,
            child: Text(
              item,
              style: GoogleFonts.roboto(
                textStyle: TextStyle(
                  color: Colors.black87, // Option text color
                  fontSize: 16.sp,
                ),
              ),
            ),
          );
        }).toList(),
        onChanged: onChanged,
        validator: validator,
      ),
    );
  }
}
