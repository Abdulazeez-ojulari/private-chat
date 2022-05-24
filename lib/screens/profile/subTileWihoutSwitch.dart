import 'package:flutter/material.dart';
import 'package:privatechat/controllers/themeNotifier.dart';
import 'package:provider/provider.dart';

class SubTile_withoutSwitch extends StatelessWidget {
  SubTile_withoutSwitch({required this.title});
  String title;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        children: [
          Divider(
            height: 2,
            color: Provider.of<ThemeNotifier>(context).darkTheme
                ? Colors.grey
                : Colors.black,
          ),
          SizedBox(
            height: 10,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(
              title,
              style: TextStyle(
                  color: Color(0xffFE9AAB),
                  fontSize: 15,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 10,
            ),
          ]),
        ],
      ),
    );
  }
}
