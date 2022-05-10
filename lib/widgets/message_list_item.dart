import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MessageListItem extends StatelessWidget {
  const MessageListItem(
      {Key? key,
      this.friendImage,
      required this.friendName,
      required this.friendMessagePreview,
      this.messageTime,
      required this.onTap})
      : super(key: key);
  final String? friendImage;
  final String friendName;
  final String friendMessagePreview;
  final DateTime? messageTime;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: CircleAvatar(
        radius: 25,
        backgroundImage:
            friendImage == null ? const AssetImage('images/avatar.png') : null,
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
                child: Image.network(
                  friendImage!,
                  height: friendImage == null ? 0 : 50,
                  width: friendImage == null ? 0 : 50,
                ),
              ),
      ),
      title: Text(
        friendName,
        style: GoogleFonts.poppins(
            color: const Color(0xff201f24),
            fontWeight: FontWeight.w600,
            fontSize: 15),
        textAlign: TextAlign.left,
      ),
      subtitle: Text(
        friendMessagePreview,
        style: GoogleFonts.poppins(
            color: const Color(0xff201f24),
            fontWeight: FontWeight.w500,
            fontSize: 14),
        textAlign: TextAlign.left,
      ),
      trailing: Text(
        messageTime?.day.toString() ?? 'Now',
        textAlign: TextAlign.left,
        style: GoogleFonts.poppins(
            color: const Color(0xff201f24),
            fontWeight: FontWeight.w600,
            fontSize: 15),
      ),
    );
  }
}
