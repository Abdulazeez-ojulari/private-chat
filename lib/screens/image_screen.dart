import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:privatechat/controllers/themeNotifier.dart';
import 'package:privatechat/utils/dark_theme_preference.dart';
import 'package:provider/provider.dart';

class ImageScreen extends StatelessWidget {
  const ImageScreen({Key? key, required this.imageUrl}) : super(key: key);
  final String imageUrl;

  static Future show(BuildContext context, String imageUrl) {
    return Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => ImageScreen(imageUrl: imageUrl)));
  }

  @override
  Widget build(BuildContext context) {
    final darkTheme = Provider.of<ThemeNotifier>(context).darkTheme;
    return Scaffold(
      backgroundColor: darkTheme ? Colors.transparent : Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme:
            IconThemeData(color: darkTheme ? Colors.white : Colors.black),
      ),
      body: Center(
        child: InteractiveViewer(
          child: CachedNetworkImage(
            imageUrl: imageUrl,
            placeholder: (context, image) =>
                const Center(child: CircularProgressIndicator()),
            errorWidget: (context, url, error) => const Icon(Icons.error),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.86,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
