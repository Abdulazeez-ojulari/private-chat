import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class preferenceScreenButtons extends StatelessWidget {
  preferenceScreenButtons({
    Key? key,
    required this.height,
    required this.width,
    required this.text,
  }) : super(key: key);

  final double height;
  final double width;
  String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 2,
          color: Color(0xffFE9AAB),
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      height: height * 0.045,
      width: width * 0.25,
      child: GestureDetector(
        onTap: (() {
          //Do Something with the button.
        }),
        child: Center(
          child: Text(
            text,
            style: GoogleFonts.poppins(
              fontSize: 13,
              color: Color(0xffFE9AAB),
            ),
          ),
        ),
      ),
    );
  }
}
