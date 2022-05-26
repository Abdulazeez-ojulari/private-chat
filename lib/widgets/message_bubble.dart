import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:privatechat/constants/constants.dart';
import 'package:privatechat/screens/image_screen.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble(
      {Key? key,
      required this.isSender,
      required this.text,
      required this.isImageText,
      this.imageUrl})
      : super(key: key);
  final bool isSender;
  final String text;
  final bool isImageText;
  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    debugPrint(imageUrl);
    return Align(
      alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
      child: isImageText
          ? Padding(
              padding: const EdgeInsets.only(top: 20.0, right: 5, left: 5),
              child: GestureDetector(
                onTap: () => ImageScreen.show(context, imageUrl!),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CachedNetworkImage(
                    imageUrl: imageUrl!,
                    placeholder: (context, image) =>
                        const Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                    width: Sizes.dimen_200,
                    height: Sizes.dimen_200,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            )
          : Container(
              margin: const EdgeInsets.only(top: 20, right: 5, left: 5),
              constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.65),
              decoration: BoxDecoration(
                  color: isSender
                      ? const Color(0xffff627c)
                      : const Color(0xfffe9aab),
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

Widget errorContainer() {
  return Container(
    decoration: BoxDecoration(),
    clipBehavior: Clip.hardEdge,
    child: Image.asset(
      'images/google_logo.png',
      height: Sizes.dimen_200,
      width: Sizes.dimen_200,
    ),
  );
}
