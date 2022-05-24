import 'package:cloud_firestore/cloud_firestore.dart';

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
}
