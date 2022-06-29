import 'dart:math';

import 'package:flutter/material.dart';
import 'package:privatechat/controllers/call.controller.dart';
import 'package:privatechat/models/call.dart';
import 'package:privatechat/models/user.dart';
import 'package:privatechat/screens/call_screen.dart';
// import 'package:skype_clone/utils/utilities.dart';

class CallUtils {
  static final CallController callController = CallController();

  static dial({required UserModel from, required UserModel to, context}) async {
    // int id = DateTime.now().millisecondsSinceEpoch;
    String channelId = Random().nextInt(2000000000).toString();
    int callId = Random().nextInt(2000000000);
    Call call = Call(
        callerId: from.id,
        callId: callId,
        callerName: from.name,
        callerPic: from.photoUrl,
        receiverId: to.id,
        receiverName: to.name,
        receiverPic: to.photoUrl,
        channelId: channelId);

    bool callMade = await callController.makeCall(call: call);

    call.hasDialled = true;

    if (callMade) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CallScreen(call: call),
          ));
    }
  }
}
