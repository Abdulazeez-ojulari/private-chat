import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:privatechat/services.dart/storage.dart';
import 'package:privatechat/screens/landing_page.dart';
import 'package:privatechat/services.dart/auth.dart';
import 'package:privatechat/controllers/themeNotifier.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

final themeChangeProvider = ThemeNotifier();
Future<void> getCurrentAppTheme() async {
  themeChangeProvider.status2 =
      await themeChangeProvider.darkThemePreference.getButtonStatus();
  themeChangeProvider.darkTheme =
      await themeChangeProvider.darkThemePreference.getTheme();
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await getCurrentAppTheme();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    getCurrentAppTheme();
  }

  @override
  Widget build(BuildContext context) {
    getCurrentAppTheme();

    return MultiProvider(
        providers: [
          ChangeNotifierProvider<ThemeNotifier>(
            create: (_) => themeChangeProvider,
          ),
          Provider<AuthBase>(
            create: (_) => Auth(),
          ),
           Provider<Storage>(create: (_) => FirestoreStorage(),)
        ],
        builder: (context, child) {
          return const MaterialApp(
              debugShowCheckedModeBanner: false, home: LandingPage());
        });
  }
}
