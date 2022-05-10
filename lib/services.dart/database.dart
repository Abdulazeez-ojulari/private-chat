//Handle CRUD operations in this file

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:privatechat/models/user.dart';
import 'package:privatechat/services.dart/api_path.dart';
import 'package:privatechat/services.dart/firestore.dart';

abstract class DataBase{
  Future<void> createUserinDatabase(User? user);
  Stream<List<UserModel>> usersStream();
}

class FirestorDatabase implements DataBase{
  FirestorDatabase(this.uid);
  final String uid;

  final _firestoreService = FirestoreService.instance;
 


  @override
  Future<void> createUserinDatabase(User? user) => _firestoreService.setData(path: APIPath.user(uid: user?.uid ?? ''), data: {
    'userId': user?.uid ?? '',
    'email' : user?.email ?? '',
    'name' : user?.displayName ?? '',
    'createdAt': DateTime.now().millisecondsSinceEpoch,
    'photoURL' : user?.photoURL ?? '',
    'chattingWith' : null
    }
    );

  @override
  Stream<List<UserModel>> usersStream() => _firestoreService.collectionStream(path: 'users', builder: (data, documentId) => UserModel.fromMap(data, documentId), queryBuilder: (query) => query!.orderBy('createdAt'));
    
  

}

