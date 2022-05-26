import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:privatechat/models/message.dart';
import 'package:privatechat/widgets/last_message_container.dart';
import 'package:privatechat/widgets/time_widget.dart';

class MessageListItem extends StatelessWidget {
  const MessageListItem(
      {Key? key,
      this.friendImage,
      required this.friendName,
      required this.stream,
      this.messageTime,
      required this.onTap,
      required this.textColor})
      : super(key: key);
  final String? friendImage;
  final String friendName;
  final Stream<List<Message>> stream;
  final DateTime? messageTime;
  final VoidCallback onTap;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return ListTile(
        onTap: onTap,
        leading: CircleAvatar(
          radius: 25,
          backgroundImage: friendImage == null
              ? const AssetImage('images/avatar.png')
              : null,
          backgroundColor: Colors.grey,
          child: friendImage == null
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: Image.asset(
                    'images/avatar.png',
                    height: 50,
                    width: 50,
                  ),
                )
              : ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: CachedNetworkImage(
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                    imageUrl: friendImage!,
                    placeholder: (context, image) =>
                         Image.asset(
                    'images/avatar.png',
                    height: 50,
                    width: 50,
                  ),
                    height: friendImage == null ? 0 : 50,
                    width: friendImage == null ? 0 : 50,
                  ),
                ),
        ),
        title: Text(
          friendName,
          style: TextStyle(
              fontWeight: FontWeight.w600, fontSize: 18, color: textColor),
          textAlign: TextAlign.left,
        ),
        subtitle: LastMessage(stream: stream),
        trailing: LastTimeMessage(stream: stream));
  }
}
