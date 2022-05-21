import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:privatechat/screens/chat_screen.dart';
import 'package:privatechat/screens/home_page.dart';
import 'package:privatechat/screens/new_home/new_home_page.dart';
import 'package:privatechat/screens/sign_in_page.dart';
import 'package:privatechat/services.dart/auth.dart';
import 'package:privatechat/services.dart/database.dart';
import 'package:privatechat/utils/themeNotifier.dart';
import 'package:provider/provider.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthBase>(
          create: (_) => Auth(),
        ),
        Provider<DataBase>(
          create: (_) => FirestorDatabase(''),
        ),
        ChangeNotifierProvider<ThemeNotifier>(
          create: (_) => ThemeNotifier(),
        )
      ],
      builder: (context, widget) {
        final auth = Provider.of<AuthBase>(context, listen: false);
        return StreamBuilder<User?>(
            stream: auth.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.active) {
                final user = snapshot.data;
                return MaterialApp(
                  debugShowCheckedModeBanner: false,
                  title: 'Private.Chat',
                  theme: Provider.of<ThemeNotifier>(context).darkTheme
                      ? dark
                      : light,
                  home:
                      user == null ? SignInPage.create(context) : NewHomePage(),
                );
              }
              return const MaterialApp(
                  title: 'Private.Chat',
                  home: Scaffold(
                    body: Center(child: CircularProgressIndicator()),
                  ));
            });
      },
    );
  }
}
