import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:privatechat/screens/home_page.dart';
import 'package:privatechat/screens/landing_page.dart';
import 'package:privatechat/screens/new_home/new_home_page.dart';
import 'package:privatechat/services.dart/auth.dart';
import 'package:privatechat/services.dart/database.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'utils/themeNotifier.dart';

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
    return MultiProvider(
      providers: [
        Provider<AuthBase>(
          create: (_) => Auth(),
        ),
        Provider<DataBase>(
          create: (_) => FirestorDatabase(''),
        ),
        ListenableProvider<ThemeNotifier>(
          create: (_) => ThemeNotifier(),
        )
      ],
      builder: (context, widget) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Private.Chat',
          theme: Provider.of<ThemeNotifier>(context).darkTheme ? dark : light,
          home: LandingPage(),
        );
      },
    );
  }
}
