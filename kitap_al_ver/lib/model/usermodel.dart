import 'package:cloud_firestore/cloud_firestore.dart';

class Usermodel {
  String username;
  String profile;
  String bio;
  List followers;
  List following;

  Usermodel({
    required this.username,
    required this.profile,
    required this.bio,
    required this.followers,
    required this.following,
  });

  factory Usermodel.fromFirestore(DocumentSnapshot doc) {
    var data = doc.data() as Map<String, dynamic>;
    return Usermodel(
      username: data['username'] ?? '',
      profile: data['profile'] ?? 'default_profile_url', // Varsayılan profil fotoğrafı URL'si
      bio: data['bio'] ?? '',
      followers: data['followers'] ?? [],
      following: data['following'] ?? [],
    );
  }

 
}