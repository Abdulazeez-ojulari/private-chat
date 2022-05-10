import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
  @override
  Widget build(BuildContext context) {
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
                      onPressed: null,
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
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ListView(
              shrinkWrap: true,
              padding: EdgeInsets.all(10),
              children: [
                Stack(
                  alignment: Alignment.bottomLeft,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20.0),
                      child: Container(
                        height: 235,
                        width: 194,
                        child: Image(
                          image: AssetImage('images/Rectangle 26.png'),
                        ),
                      ),
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      decoration: BoxDecoration(
                        color: Color(0xffFF647C),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.0),
                          bottomRight: Radius.circular(20.0),
                          topRight: Radius.circular(20.0),
                        ),
                      ),
                      child: Text(
                        'They are great',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Stack(
                  alignment: Alignment.topRight,
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.0),
                          bottomLeft: Radius.circular(20.0),
                          topRight: Radius.circular(20.0),
                        ),
                        color: Color(0xffFF647C),
                      ),
                      child: Text(
                        'Really where',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Stack(
              children: [
                Container(
                  padding: EdgeInsets.only(left: 10, bottom: 10, top: 10),
                  decoration: BoxDecoration(
                    color: Color(0xffF5F5F5),
                    borderRadius: BorderRadius.all(
                      Radius.circular(50),
                    ),
                  ),
                  height: 60,
                  width: double.infinity,
                  child: Row(
                    children: [
                      TextButton(
                        onPressed: () {},
                        child: Icon(
                          Icons.camera_alt,
                          color: Colors.black,
                          size: 20,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                              hintText: 'Type something',
                              hintStyle: TextStyle(color: Colors.black54),
                              border: InputBorder.none),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Icon(
                          Icons.mic_rounded,
                          color: Colors.black,
                          size: 20,
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Icon(
                          Icons.photo_rounded,
                          color: Colors.black,
                          size: 20,
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Icon(
                          Icons.send_rounded,
                          color: Color(0xffFF647C),
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
