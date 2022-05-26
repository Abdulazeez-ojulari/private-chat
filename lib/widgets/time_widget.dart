import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:privatechat/controllers/themeNotifier.dart';
import 'package:privatechat/models/message.dart';
import 'package:privatechat/utils/time_format.dart';
import 'package:provider/provider.dart';

class LastTimeMessage extends StatelessWidget {
  const LastTimeMessage({Key? key, required this.stream}) : super(key: key);

  final Stream<List<Message>> stream;

  @override
  Widget build(BuildContext context) {
    final darkTheme = Provider.of<ThemeNotifier>(context).darkTheme;
    return StreamBuilder<List<Message>>(
      stream: stream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var msgList = snapshot.data!;
          if (msgList.isNotEmpty) {
            final lastMessageTime = msgList.first.timeStamp;

            final formattedTime = TimeFormat.readTimestamp(lastMessageTime);
            return Text(
              formattedTime,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14,
                color: darkTheme ? Colors.white : Colors.black,
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
