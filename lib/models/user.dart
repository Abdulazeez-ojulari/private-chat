
import 'dart:math';

class UserModel{
  UserModel( {required this.name, required this.email, required this.id, this.photoUrl, required this.createdAt,required this.chattingWith,});
  final String name;
  final String email;
  final String? photoUrl;
  final String createdAt;
  final String? chattingWith;
  final String id;

  factory UserModel.fromMap(Map<String, dynamic>? data, String documentId){
    final name = data?['name'] ?? '';
    final email = data?['email'] ?? '';
    final photoUrl = data?['photoURl'] ?? '';
    final createdAt = data?['createdAt'].toString() ?? '';
    final chattingWith = data?['chattingWith'].toString() ?? '';
    return UserModel(
      name: name,
      email: email,
      id: documentId,
      chattingWith: chattingWith,
      createdAt: createdAt,
      photoUrl: photoUrl

    );
  }

}