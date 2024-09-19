// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bildirimler"),
      ),
      body: Container(
        child: const Text("Bildirim"),
      ),
    );
  }
}
