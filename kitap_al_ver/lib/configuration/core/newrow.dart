// ignore_for_file: use_super_parameters

import 'package:flutter/material.dart';

class NewRow extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback onPressed;
  final Color? textColor; // Yeni parametre ekleyin

  const NewRow({
    Key? key,
    required this.text,
    required this.icon,
    required this.onPressed,
    this.textColor, // Yeni parametre için varsayılan değer
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Row(
        children: [
          Icon(icon, color: textColor), // İkon rengi
          const SizedBox(width: 10),
          Text(
            text,
            style: TextStyle(color: textColor), // Metin rengi
          ),
        ],
      ),
    );
  }
}
