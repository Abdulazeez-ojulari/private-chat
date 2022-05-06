import 'package:flutter/material.dart';
import 'package:privatechat/widgets/preferences/preferenceScreenButtons.dart';

class Partners_gender extends StatelessWidget {
  const Partners_gender({
    Key? key,
    required this.height,
    required this.width,
  }) : super(key: key);

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            preferenceScreenButtons(height: height, width: width, text: 'Male'),
            SizedBox(
              width: width / 25,
            ),
            preferenceScreenButtons(
                height: height, width: width, text: 'Female'),
            SizedBox(
              width: width / 25,
            ),
            preferenceScreenButtons(
                height: height, width: width, text: 'Non-binary'),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            preferenceScreenButtons(
                height: height, width: width, text: 'Intersex'),
            SizedBox(
              width: width / 25,
            ),
            preferenceScreenButtons(
                height: height, width: width, text: 'Other'),
          ],
        ),
      ],
    );
  }
}
