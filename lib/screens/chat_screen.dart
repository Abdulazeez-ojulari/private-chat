import 'package:flutter/material.dart';

import 'package:privatechat/models/user.dart';
import 'package:privatechat/services.dart/auth.dart';
import 'package:privatechat/services.dart/database.dart';

import 'package:provider/provider.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key, required this.db}) : super(key: key);
  final DataBase db;

  static Future<void> show(BuildContext context, DataBase db) {
    return Navigator.of(context).push(
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
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
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
          title: const Text(
            'Anonymous  #2354',
            style: TextStyle(fontSize: 14.0, color: Colors.black),
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
                        children: const [
                          Icon(
                            Icons.person_add,
                            color: Colors.green,
                          ),
                          Text('  Add friend'),
                        ],
                      ),
                    ),
                  ),
                  PopupMenuItem(
                    child: TextButton(
                      onPressed: () => auth.signOut(),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.report_problem,
                            color: Colors.red,
                          ),
                          const Text('  Report User'),
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
                        auth.currentUser!.uid != list[index].id
                            ? list[index].name
                            : 'NoUser',
                        style: const TextStyle(color: Colors.black),
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
      bottomSheet: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 15),
        child: SizedBox(
          width: double.infinity,
          height: 70,
          child: Theme(
            data: Theme.of(context).copyWith(
              colorScheme: ThemeData().colorScheme.copyWith(
                    primary: Colors.black,
                  ),
            ),
            child: TextField(
              textInputAction: TextInputAction.newline,
              maxLines: null,
              expands: true,
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(2),
                  iconColor: Colors.black,
                  suffixIconColor: Colors.black,
                  prefixIconColor: Colors.black,
                  fillColor: const Color(0xfff5f5f5),
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
