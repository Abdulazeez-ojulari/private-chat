import 'package:flutter/material.dart';
import 'package:privatechat/widgets/preferences/preferenceScreenButtons.dart';

class partners_sexuality extends StatelessWidget {
  const partners_sexuality({
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
            preferenceScreenButtons(
                height: height, width: width, text: 'Heterosexual'),
            SizedBox(
              width: width / 25,
            ),
            preferenceScreenButtons(
                height: height, width: width, text: 'Homosexual'),
            SizedBox(
              width: width / 25,
            ),
            preferenceScreenButtons(
                height: height, width: width, text: 'Bisexual'),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            preferenceScreenButtons(
                height: height, width: width, text: 'Asexual'),
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
