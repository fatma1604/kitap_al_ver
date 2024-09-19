// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:kitap_al_ver/pages/data/firebes_auth.dart';

class Bildirim extends StatelessWidget {
   final FirebaseAuthService _authService = FirebaseAuthService();
 Bildirim({super.key});
@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bildirimler'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _authService.getNotifications(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Bir hata oluştu.'));
          }

          final notifications = snapshot.data!;
          return ListView.builder(
            itemCount: notifications.length,
            itemBuilder: (context, index) {
              final notification = notifications[index];
              return ListTile(
                title: Text(notification['title']),
                subtitle: Text(notification['message']),
                trailing: Text(notification['timestamp'].toDate().toString()), // Zamanı formatlamak isteyebilirsiniz
              );
            },
          );
        },
      ),
    );
  }

}
