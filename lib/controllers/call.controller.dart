import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:privatechat/models/call.dart';

class CallController {
  final CollectionReference callCollection =
      FirebaseFirestore.instance.collection("call");

  Stream<DocumentSnapshot> callStream({required String uid}) =>
      callCollection.doc(uid).snapshots();

  Future<bool> makeCall({required Call call}) async {
    try {
      int callId = Random().nextInt(2000000000);
      int receiveId = Random().nextInt(2000000000);

      call.hasDialled = true;
      call.callId = callId;
      call.receiveId = receiveId;
      Map<String, dynamic> hasDialledMap = call.toMap(call);

      call.hasDialled = false;
      call.callId = callId;
      call.receiveId = receiveId;
      Map<String, dynamic> hasNotDialledMap = call.toMap(call);

      await callCollection.doc(call.callerId).set(hasDialledMap);
      await callCollection.doc(call.receiverId).set(hasNotDialledMap);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> endCall({required Call call}) async {
    try {
      await callCollection.doc(call.callerId).delete();
      await callCollection.doc(call.receiverId).delete();
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
