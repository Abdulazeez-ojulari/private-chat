import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:privatechat/constants/constants.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble(
      {Key? key,
      required this.isSender,
      required this.text,
      required this.imageText})
      : super(key: key);
  final bool isSender;
  final String text;
  final bool imageText;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
      child: imageText
          ? Image.network(
              text,
              width: Sizes.dimen_200,
              height: Sizes.dimen_200,
              fit: BoxFit.cover,
              loadingBuilder: (BuildContext ctx, Widget child,
                  ImageChunkEvent? loadingProgress) {
                if (loadingProgress == null) return child;
                return Container(
                  decoration: BoxDecoration(
                    color: AppColors.greyColor2,
                    borderRadius: BorderRadius.circular(Sizes.dimen_10),
                  ),
                  width: Sizes.dimen_200,
                  height: Sizes.dimen_200,
                  child: Center(
                    child: CircularProgressIndicator(
                      color: AppColors.burgundy,
                      value: loadingProgress.expectedTotalBytes != null &&
                              loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                          : null,
                    ),
                  ),
                );
              },
              errorBuilder: (context, object, stackTrace) => errorContainer(),
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
    clipBehavior: Clip.hardEdge,
    child: Image.asset(
      'assets/images/img_not_available.jpeg',
      height: Sizes.dimen_200,
      width: Sizes.dimen_200,
    ),
  );
}
