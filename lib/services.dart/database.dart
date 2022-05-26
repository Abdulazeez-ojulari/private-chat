//Handle CRUD operations in this file

import 'package:firebase_auth/firebase_auth.dart';

import 'package:privatechat/models/message.dart';
import 'package:privatechat/models/user.dart';
import 'package:privatechat/services.dart/api_path.dart';

import 'package:privatechat/services.dart/firestore.dart';

abstract class DataBase {
  Future<void> createUserinDatabase(User? user);
  Future<void> updateUserMessageTime(int time, UserModel? user);
  Stream<List<UserModel>> usersStream(User user);
  Future<void> writeMessage(Message message, User sender, UserModel reciever);
  Stream<List<Message>> messagesStream(String senderId, String recieverId);
  Future<void> writePhotoMessage(
      Message message, User sender, UserModel reciever);
}

class FirestorDatabase implements DataBase {
  FirestorDatabase(this.uid);
  final String uid;

  final _firestoreService = FirestoreService.instance;

  @override
  Future<void> createUserinDatabase(User? user) => _firestoreService
          .setData(path: APIPath.user(uid: user?.uid ?? ''), data: {
        'userId': user?.uid ?? '',
        'email': user?.email ?? '',
        'name': user?.displayName ?? '',
        'createdAt': DateTime.now().millisecondsSinceEpoch,
        'photoURL': user?.photoURL ?? '',
        'lastMessageTime': null
      });

  @override
  Future<void> updateUserMessageTime(int time, UserModel? user) =>
      _firestoreService.setData(path: APIPath.user(uid: user?.id ?? ''), data: {
        'userId': user?.id ?? '',
        'email': user?.email ?? '',
        'name': user?.name ?? '',
        'createdAt': user?.createdAt ?? '',
        'photoURL': user?.photoUrl ?? '',
        'lastMessageTime': time
      });

  @override
  Stream<List<UserModel>> usersStream(User user) =>
      _firestoreService.collectionStream(
          path: 'users',
          builder: (data, documentId) => UserModel.fromMap(data, documentId),
          queryBuilder: (query) => query!
              // .where('userId', isNotEqualTo: user.uid)
              // .orderBy('userId', descending: false)
              .orderBy('lastMessageTime', descending: true));
            

  @override
  Future<void> writeMessage(
      Message message, User sender, UserModel reciever) async {
    var map = message.toMap();

    await _firestoreService.setCollection(
        path: APIPath.messages(id1: sender.uid, id2: reciever.id), data: map);
    return await _firestoreService.setCollection(
        path: APIPath.messages(id1: reciever.id, id2: sender.uid), data: map);
  }

  @override
  Stream<List<Message>> messagesStream(String senderId, String recieverId) =>
      _firestoreService.collectionStream(
          path: APIPath.messages(id1: senderId, id2: recieverId),
          queryBuilder: (query) =>
              query!.orderBy('timeStamp', descending: true),
          builder: (data, documetId) {
            return Message.fromMap(data);
          });

  @override
  Future<void> writePhotoMessage(
      Message message, User sender, UserModel reciever) async {
    var map = message.toMap();

    await _firestoreService.setCollection(
        path: APIPath.messages(id1: sender.uid, id2: reciever.id), data: map);
    return await _firestoreService.setCollection(
        path: APIPath.messages(id1: reciever.id, id2: sender.uid), data: map);
  }
}
