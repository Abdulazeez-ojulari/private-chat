import 'package:flutter/material.dart';
import 'package:privatechat/controllers/themeNotifier.dart';
import 'package:provider/provider.dart';

class EmptyContent extends StatelessWidget {
  const EmptyContent({
    Key? key,
    this.title = '',
    this.message = '',
  }) : super(key: key);
  final String title;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 32,
              color: Provider.of<ThemeNotifier>(context).darkTheme
                  ? const Color(0xffF5F5F5)
                  : const Color(0xff3D393A),
            ),
          ),
          Text(
            message,
            style: TextStyle(
              fontSize: 16,
              color: Provider.of<ThemeNotifier>(context).darkTheme
                  ? const Color(0xffF5F5F5)
                  : const Color(0xff3D393A),
            ),
          )
        ],
      ),
    );
  }
}
