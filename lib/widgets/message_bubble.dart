import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble({Key? key, required this.isSender, required this.text})
      : super(key: key);
  final bool isSender;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(top: 20, right: 5, left: 5),
        constraints:
            BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.65),
        decoration: BoxDecoration(
            color: isSender ? const Color(0xffff627c) : const Color(0xfffe9aab),
            borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(10),
                topRight: const Radius.circular(10),
                bottomLeft: isSender
                    ? const Radius.circular(10)
                    : const Radius.circular(0),
                bottomRight: isSender
                    ? const Radius.circular(0)
                    : const Radius.circular(10))),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(text,
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: Colors.white,
              )),
        ),
      ),
    );
  }
}
