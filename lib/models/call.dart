class Call {
  String? callerId;
  int callId;
  String? callerName;
  String? callerPic;
  String? receiverId;
  int receiveId;
  String? receiverName;
  String? receiverPic;
  String channelId;
  bool? hasDialled;

  Call({
    this.callerId,
    required this.callId,
    this.callerName,
    this.callerPic,
    this.receiverId,
    required this.receiveId,
    this.receiverName,
    this.receiverPic,
    required this.channelId,
    this.hasDialled,
  });

  // to map
  Map<String, dynamic> toMap(Call call) {
    Map<String, dynamic> callMap = Map();
    callMap["caller_id"] = call.callerId;
    callMap["call_id"] = call.callId;
    callMap["caller_name"] = call.callerName;
    callMap["caller_pic"] = call.callerPic;
    callMap["receiver_id"] = call.receiverId;
    callMap["receive_id"] = call.receiveId;
    callMap["receiver_name"] = call.receiverName;
    callMap["receiver_pic"] = call.receiverPic;
    callMap["channel_id"] = call.channelId;
    callMap["has_dialled"] = call.hasDialled;
    return callMap;
  }

  // Call.fromMap(Map callMap) {
  //   callerId = callMap["caller_id"];
  //   callerName = callMap["caller_name"];
  //   callerPic = callMap["caller_pic"];
  //   receiverId = callMap["receiver_id"];
  //   receiveId = callMap?["receive_id"] ?? 0;
  //   receiverName = callMap["receiver_name"];
  //   receiverPic = callMap["receiver_pic"];
  //   channelId = callMap["channel_id"];
  //   hasDialled = callMap["has_dialled"];
  // }

  factory Call.fromMap(Map<String, dynamic>? callMap) {
    return Call(
      callerId: callMap?["caller_id"],
      callId: callMap?["call_id"],
      callerName: callMap?["caller_name"],
      callerPic: callMap?["caller_pic"],
      receiverId: callMap?["receiver_id"],
      receiveId: callMap?["receive_id"] ?? 0,
      receiverName: callMap?["receiver_name"],
      receiverPic: callMap?["receiver_pic"],
      channelId: callMap?["channel_id"],
      hasDialled: callMap?["has_dialled"],
    );
  }
}
