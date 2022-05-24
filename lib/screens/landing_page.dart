import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:privatechat/main.dart';
import 'package:privatechat/screens/new_home/new_home_page.dart';
import 'package:privatechat/screens/sign_in_page.dart';
import 'package:privatechat/services.dart/auth.dart';
import 'package:privatechat/services.dart/database.dart';
import 'package:privatechat/controllers/themeNotifier.dart';
import 'package:provider/provider.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);
    return StreamBuilder<User?>(
        stream: auth.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            final user = snapshot.data;

            if (user == null) {
              return SignInPage.create(context);
            }

            return Provider<DataBase>(
                create: (_) => FirestorDatabase(user.uid),
                child: const NewHomePage());
          }
          return Scaffold(
            backgroundColor: Provider.of<ThemeNotifier>(context).darkTheme
                ? Colors.white
                : Colors.black,
            body: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
  }
}
