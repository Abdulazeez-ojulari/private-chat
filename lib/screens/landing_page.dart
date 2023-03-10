import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:privatechat/screens/chat_screen.dart';
import 'package:privatechat/screens/home_page.dart';
import 'package:privatechat/screens/new_home/new_home_page.dart';
import 'package:privatechat/screens/sign_in_page.dart';
import 'package:privatechat/services.dart/auth.dart';
import 'package:privatechat/services.dart/database.dart';
import 'package:provider/provider.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

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
            //  auth.signOut();
         
            return Provider<DataBase>(
                create: (_) => FirestorDatabase(user.uid),
                child: const NewHomePage());
          }
          return const Scaffold(
            backgroundColor: Colors.white,
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        });

  }
}
