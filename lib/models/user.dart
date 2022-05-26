
import 'dart:math';

class UserModel{
  UserModel( {required this.name, required this.email, required this.id, this.photoUrl, required this.createdAt,required this.chattingWith, required this.lastMessageTime, });
  final String name;
  final String email;
  final String? photoUrl;
  final String createdAt;
  final String? chattingWith;
  final String id;
  final int lastMessageTime;

  factory UserModel.fromMap(Map<String, dynamic>? data, String documentId){
    final name = data?['name'] ?? '';
    final email = data?['email'] ?? '';
    final photoUrl = data?['photoURL'] ?? '';
    final createdAt = data?['createdAt'].toString() ?? '';
    final chattingWith = data?['chattingWith'].toString() ?? '';
    final lastMessageTime = data?['lastMessageTime'] ?? '';

    return UserModel(
      name: name,
      email: email,
      id: documentId,
      chattingWith: chattingWith,
      createdAt: createdAt,
      photoUrl: photoUrl,
  lastMessageTime: lastMessageTime
    );
  }

}