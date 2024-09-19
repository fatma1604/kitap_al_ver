import 'package:flutter/material.dart';

showAlertDialog({
  required BuildContext context,
  required String message,
  String? btnText,
}) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: const Color.fromARGB(255, 247, 100, 113),
        content: Text(
          message,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 15,
          ),
        ),
        contentPadding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              btnText ?? "OK",
              style: const TextStyle(color: Colors.black),
            ),
          ),
        ],
      );
    },
  );
}
