import 'package:cloud_firestore/cloud_firestore.dart';

class Mesage {
  final String senderID;
  final String senderEmail;
  final String receiverId;
  final String message;
  final Timestamp timestamp;

  Mesage({
    required this.senderID,
    required this.senderEmail,
    required this.receiverId,
    required this.message,
    required this.timestamp,
  });

  // fromMap methodunu ekliyoruz
  factory Mesage.fromMap(Map<String, dynamic> data) {
    return Mesage(
      senderID: data['senderID'] as String,
      senderEmail: data['senderEmail'] as String,
      receiverId: data['receiverId'] as String,
      message: data['message'] as String,
      timestamp: data['timestamp'] as Timestamp,
    );
  }

  // toMap methodu, veriyi Firestore'a eklemek için kullanılabilir
  Map<String, dynamic> toMap() {
    return {
      'senderID': senderID,
      'senderEmail': senderEmail,
      'receiverId': receiverId,
      'message': message,
      'timestamp': timestamp,
    };
  }
}
