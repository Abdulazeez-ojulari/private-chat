import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:privatechat/constants/firestore_constants.dart';
import 'package:privatechat/models/message.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatController {
  final SharedPreferences? prefs;
  final FirebaseFirestore firebaseFirestore;
  final FirebaseStorage firebaseStorage;

  ChatController(
      {this.prefs,
      required this.firebaseStorage,
      required this.firebaseFirestore});

  UploadTask uploadImageFile(File image, String filename) {
    Reference reference = firebaseStorage.ref().child(filename);
    UploadTask uploadTask = reference.putFile(image);
    return uploadTask;
  }

  Future<void> updateFirestoreData(
      String collectionPath, String docPath, Map<String, dynamic> dataUpdate) {
    return firebaseFirestore
        .collection(collectionPath)
        .doc(docPath)
        .update(dataUpdate);
  }

  Stream<QuerySnapshot> getChatMessage(String groupChatId, int limit) {
    return firebaseFirestore
        .collection(FirestoreConstants.pathMessageCollection)
        .doc(groupChatId)
        .collection(groupChatId)
        .orderBy(FirestoreConstants.timestamp, descending: true)
        .limit(limit)
        .snapshots();
  }

  void sendChatMessage(String content, String type, String groupChatId,
      String currentUserId, String peerId) {
    DocumentReference documentReference = firebaseFirestore
        .collection(FirestoreConstants.pathMessageCollection)
        .doc(currentUserId)
        .collection(peerId)
        .doc();

    DocumentReference document2Reference = firebaseFirestore
        .collection(FirestoreConstants.pathMessageCollection)
        .doc(peerId)
        .collection(currentUserId)
        .doc();
    Message chatMessages = Message(
        senderId: currentUserId,
        recieverId: peerId,
        timeStamp: DateTime.now().millisecondsSinceEpoch,
        message: content,
        type: type);

    FirebaseFirestore.instance.runTransaction((transaction) async {
      transaction.set(documentReference, chatMessages.toJson());
    });
    FirebaseFirestore.instance.runTransaction((transaction) async {
      transaction.set(document2Reference, chatMessages.toJson());
    });
  }
}

class MessageType {
  static const text = 0;
  static const image = '1';
  static const sticker = 2;
}
