import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:privatechat/controllers/themeNotifier.dart';
import 'package:privatechat/models/message.dart';
import 'package:privatechat/services.dart/auth.dart';
import 'package:provider/provider.dart';

class LastMessage extends StatelessWidget {
  const LastMessage({Key? key, required this.stream}) : super(key: key);

  final Stream<List<Message>> stream;

  @override
  Widget build(BuildContext context) {
    final darkTheme = Provider.of<ThemeNotifier>(context).darkTheme;
    final auth = Provider.of<AuthBase>(context, listen: false);
    return StreamBuilder<List<Message>>(
      stream: stream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var msgList = snapshot.data!;
          if (msgList.isNotEmpty) {
            final lastMessage = msgList.first;
            final isPhotoMessage = lastMessage.type == 'image';
            final isSender = lastMessage.senderId == auth.currentUser!.uid;
            return Text(
              isPhotoMessage
                  ? '🖼️ photo'
                  : isSender
                      ? 'You: ${lastMessage.message!}'
                      : lastMessage.message!,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 14,
                color: darkTheme ? Colors.white60 : Colors.black,
              ),
              textAlign: TextAlign.left,
            );
          }

          return const Text('');
        }
        return const Text('');
      },
    );
  }
}
