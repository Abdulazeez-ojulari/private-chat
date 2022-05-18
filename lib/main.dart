import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:privatechat/screens/home_page.dart';
import 'package:privatechat/screens/landing_page.dart';
import 'package:privatechat/services.dart/auth.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Provider<AuthBase>(
      create: (_) => Auth(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Private.Chat',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const LandingPage(),
      ),
    );
  }
}
