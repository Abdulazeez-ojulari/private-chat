import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:privatechat/models/user.dart';
import 'package:privatechat/services.dart/auth.dart';
import 'package:privatechat/services.dart/database.dart';
import 'package:privatechat/services.dart/firestore.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  static Future<void> show(BuildContext context) {
    return Navigator.of(context, rootNavigator: true).push(
      MaterialPageRoute(
        builder: (context) => const ChatScreen(),
      ),
    );
  }

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _fireStore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    final db = Provider.of<DataBase>(context, listen: false);
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
              children: [
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
            style: TextStyle(fontSize: 14.0, color: Colors.black),
          ),
          actions: [
            IconButton(
                onPressed: null,
                icon: Icon(
                  Icons.call,
                  color: Colors.pinkAccent,
                )),
            IconButton(
                onPressed: null,
                icon: Icon(
                  Icons.video_call,
                  color: Colors.pinkAccent,
                )),
            PopupMenuButton(
              elevation: 5,
              child: Center(
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
                          Icon(
                            Icons.report_problem,
                            color: Colors.red,
                          ),
                          Text('  Report User'),
                        ],
                      ),
                    ),
                  ),
                ];
              },
            ),
          ]),
      body: StreamBuilder<List<UserModel>>(
        stream: db.usersStream(),
        builder: (context, snapshot) {
         
          if (snapshot.hasData) {
            final list = snapshot.data;
            final userList = <UserModel>[];
            // for (var item in list!.docs) {
            //    var list  = UserModel.fromMap(item.reference , '');
            //    userList.add(list);
            // }
           print(list);
            print(auth.currentUser!.email);

            return ListView.builder(
                itemCount: list!.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Text(
                        auth.currentUser!.uid != list[index].id
                            ? list[index].name
                            : 'NoUser',
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
                  );
                });
          } else if (snapshot.hasError) {
            Column(
              children: [
                Center(
                  child: Text('Error'),
                ),
              ],
            );
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }
}
