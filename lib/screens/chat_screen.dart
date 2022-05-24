import 'package:flutter/material.dart';

import 'package:privatechat/models/user.dart';
import 'package:privatechat/services.dart/auth.dart';
import 'package:privatechat/services.dart/database.dart';
import 'package:privatechat/controllers/themeNotifier.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key, required this.db}) : super(key: key);
  final DataBase db;

  static Future<void> show(BuildContext context, DataBase db) {
    return Navigator.of(context, rootNavigator: true).push(
      MaterialPageRoute(
        builder: (context) => ChatScreen(
          db: db,
        ),
      ),
    );
  }

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  Future<void> secureScreen() async {
    await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
  }

  Future<void> clearSecureScreen() async {
    await FlutterWindowManager.clearFlags(FlutterWindowManager.FLAG_SECURE);
  }

  final key = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    secureScreen();
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    clearSecureScreen();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);
    return Theme(
      data: Theme.of(context).copyWith(
          colorScheme: ThemeData().colorScheme.copyWith(
                primary: Colors.black,
              ),
          bottomSheetTheme: BottomSheetThemeData(
            backgroundColor: Provider.of<ThemeNotifier>(context).darkTheme
                ? const Color(0xff201F24)
                : const Color(0xfff1f1f1),
            modalBackgroundColor: Provider.of<ThemeNotifier>(context).darkTheme
                ? const Color(0xff201F24)
                : const Color(0xfff1f1f1),
          )),
      child: Scaffold(
        key: key,
        resizeToAvoidBottomInset: true,
        backgroundColor: Provider.of<ThemeNotifier>(context).darkTheme
            ? const Color(0xff201F24)
            : const Color(0xfff1f1f1),
        appBar: AppBar(
            backgroundColor: Provider.of<ThemeNotifier>(context).darkTheme
                ? const Color(0xff201F24)
                : const Color(0xfff1f1f1),
            elevation: 0.0,
            leading: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Row(
                children: const [
                  Icon(
                    Icons.arrow_back_ios_new_rounded,
                    size: 16,
                    color: Colors.pinkAccent,
                  ),
                  CircleAvatar(
                    backgroundColor: Colors.transparent,
                    child: Image(
                      height: 30,
                      width: 30,
                      image: AssetImage('images/avatar.png'),
                    ),
                  ),
                ],
              ),
            ),
            title: Text(
              'Anonymous  #2354',
              style: TextStyle(
                fontSize: 14.0,
                color: Provider.of<ThemeNotifier>(context).darkTheme
                    ? Colors.white
                    : Colors.black,
              ),
            ),
            actions: [
              const IconButton(
                  onPressed: null,
                  icon: Icon(
                    Icons.call,
                    color: Colors.pinkAccent,
                  )),
              const IconButton(
                  onPressed: null,
                  icon: Icon(
                    Icons.video_call,
                    color: Colors.pinkAccent,
                  )),
              PopupMenuButton(
                elevation: 5,
                color: Provider.of<ThemeNotifier>(context).darkTheme
                    ? const Color(0xff201F24)
                    : const Color(0xfff1f1f1),
                child: const Center(
                    child: Icon(
                  Icons.more_vert,
                  color: Colors.pinkAccent,
                )),
                itemBuilder: (context) {
                  return [
                    PopupMenuItem(
                      child: TextButton(
                        onPressed: null,
                        child: Row(
                          children: [
                            const Icon(
                              Icons.person_add,
                              color: Colors.green,
                            ),
                            Text(
                              '  Add friend',
                              style: TextStyle(
                                color: Provider.of<ThemeNotifier>(context,
                                            listen: false)
                                        .darkTheme
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    PopupMenuItem(
                      child: TextButton(
                        onPressed: () {
                          auth.signOut();
                        },
                        child: Row(
                          children: [
                            const Icon(
                              Icons.report_problem,
                              color: Colors.red,
                            ),
                            Text(
                              '  Report User',
                              style: TextStyle(
                                color: Provider.of<ThemeNotifier>(context,
                                            listen: false)
                                        .darkTheme
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ];
                },
              ),
            ]),
        body: StreamBuilder<List<UserModel>>(
          stream: widget.db.usersStream(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final list = snapshot.data;

              return ListView.builder(
                  itemCount: list!.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Text(
                          auth.currentUser?.uid != list[index].id
                              ? list[index].name
                              : 'NoUser',
                          style: TextStyle(
                              color:
                                  Provider.of<ThemeNotifier>(context).darkTheme
                                      ? Colors.white
                                      : Colors.black),
                        ),
                      ],
                    );
                  });
            } else if (snapshot.hasError) {
              Column(
                children: const [
                  Center(
                    child: Text('Error'),
                  ),
                ],
              );
            }
            return const CircularProgressIndicator();
          },
        ),
        bottomSheet: SizedBox(
          height: 70,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
            child: TextField(
              textInputAction: TextInputAction.newline,
              maxLines: null,
              expands: true,
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(2),
                  iconColor: Colors.black,
                  suffixIconColor: Colors.black,
                  prefixIconColor: Colors.black,
                  fillColor: Provider.of<ThemeNotifier>(context).darkTheme
                      ? const Color(0xff3D393A)
                      : const Color(0xffF5F5F5),
                  filled: true,
                  prefixIcon: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.photo_camera_rounded)),
                  suffixIcon: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(onPressed: () {}, icon: const Icon(Icons.mic)),
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.photo_outlined)),
                      IconButton(
                          onPressed: () {}, icon: const Icon(Icons.send)),
                    ],
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: BorderSide.none)),
            ),
          ),
        ),
      ),
    );
  }
}
