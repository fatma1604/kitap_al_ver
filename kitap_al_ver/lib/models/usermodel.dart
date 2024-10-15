import 'package:cloud_firestore/cloud_firestore.dart';

class Usermodel {
  final String username;
  final String bio;
  final String profile;
  final String email; 
  final List followers;
  final List following;

  Usermodel({
    required this.username,
    required this.bio,
    required this.profile,
    required this.email, 
    required this.followers,
    required this.following,
  });

  factory Usermodel.fromFirestore(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return Usermodel(
      username: data['username'] ?? '',
      bio: data['bio'] ?? '',
      profile: data['profile'] ?? '',
      email: data['email'] ?? '', 
      followers: data['followers'] ?? [],
      following: data['following'] ?? [],
    );
  }
}
