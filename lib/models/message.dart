import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:privatechat/constants/constants.dart';

class Message {
  Message(
      {required this.senderId,
      required this.recieverId,
      required this.type,
      required this.timeStamp,
      required this.message,
      this.photoUrl});

  //to send photo message
  Message.photoMessage(
      {required this.senderId,
      required this.recieverId,
      required this.type,
      required this.timeStamp,
      required this.photoUrl,
      required this.message});
  final String senderId;
  final String recieverId;
  final String type;
  final String message;
  final int timeStamp;
  final String? photoUrl;

  toMap() {
    return <String, dynamic>{
      'senderId': senderId,
      'recieverId': recieverId,
      'type': type,
      'message': message,
      'timeStamp': timeStamp,
      'photoUrl': photoUrl
    };
  }

  factory Message.fromMap(Map<String, dynamic>? map) {
    return Message(
      message: map?['message'] ?? '',
      senderId: map?['senderId'] ?? '',
      recieverId: map?['recieverId'] ?? '',
      timeStamp: map?['timeStamp'] ?? '',
      type: map?['type'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      FirestoreConstants.idFrom: senderId,
      FirestoreConstants.idTo: recieverId,
      FirestoreConstants.timestamp: timeStamp,
      FirestoreConstants.content: message,
      FirestoreConstants.type: type,
    };
  }

  factory Message.fromDocument(DocumentSnapshot documentSnapshot) {
    String idFrom = documentSnapshot.get(FirestoreConstants.idFrom);
    String idTo = documentSnapshot.get(FirestoreConstants.idTo);
    int timestamp = documentSnapshot.get(FirestoreConstants.timestamp);
    String content = documentSnapshot.get(FirestoreConstants.content);
    String type = documentSnapshot.get(FirestoreConstants.type);

    return Message(
        senderId: idFrom,
        recieverId: idTo,
        timeStamp: timestamp,
        message: content,
        type: type);
  }
}
