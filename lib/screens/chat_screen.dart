import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:privatechat/constants/constants.dart';
import 'package:privatechat/controllers/chat.controller.dart';
import 'package:privatechat/models/message.dart';

import 'package:privatechat/models/user.dart';
import 'package:privatechat/services.dart/auth.dart';
import 'package:privatechat/services.dart/database.dart';
import 'package:privatechat/controllers/themeNotifier.dart';

import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:privatechat/widgets/common_widgets.dart';

import 'package:privatechat/widgets/list_item_builder.dart';
import 'package:privatechat/widgets/message_bubble.dart';

import 'package:provider/provider.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key, required this.db, required this.reciever})
      : super(key: key);
  final DataBase db;
  final UserModel reciever;

  static Future<void> show(
      BuildContext context, DataBase db, UserModel reciever) {
    return Navigator.of(context, rootNavigator: true).push(
      MaterialPageRoute(
        builder: (context) => ChatScreen(
          db: db,
          reciever: reciever,
        ),
      ),
    );
  }

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  String? currentUserId;
  Future<void> secureScreen() async {
    await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
  }

  Future<void> clearSecureScreen() async {
    await FlutterWindowManager.clearFlags(FlutterWindowManager.FLAG_SECURE);
  }

  final key = GlobalKey<ScaffoldState>();

  int _limit = 20;
  final int _limitIncrement = 20;

  File? imageFile;
  String imageUrl = '';
  bool isLoading = false;
  bool isShowSticker = false;

  String groupChatId = '';

  TextEditingController textEditingController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  final FocusNode focusNode = FocusNode();
  final controller = ScrollController();
  double position = 0;

  ChatController? chatController;

  @override
  void initState() {
    secureScreen();
    super.initState();
    chatController = context.read<ChatController>();

    if (controller.hasClients) {
      controller.animateTo(
        controller.position.maxScrollExtent,
        curve: Curves.easeOut,
        duration: const Duration(milliseconds: 500),
      );
    }
    // focusNode.addListener(onFocusChanged);
    // scrollController.addListener(_scrollListener);
    readLocal();
  }

  _scrollListener() {
    if (scrollController.offset >= scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
      setState(() {
        _limit += _limitIncrement;
      });
    }
  }

  void onFocusChanged() {
    if (focusNode.hasFocus) {
      setState(() {
        isShowSticker = false;
      });
    }
  }

  void readLocal() {
    // if (authProvider.getFirebaseUserId()?.isNotEmpty == true) {
    //   currentUserId = authProvider.getFirebaseUserId()!;
    // } else {
    //   Navigator.of(context).pushAndRemoveUntil(
    //       MaterialPageRoute(builder: (context) => const LoginPage()),
    //       (Route<dynamic> route) => false);
    // }
    // if (currentUserId.compareTo(widget.reciever.id) > 0) {
    //   groupChatId = '$currentUserId - ${widget.reciever.id}';
    // } else {
    //   groupChatId = '${widget.reciever.id} - $currentUserId';
    // }
    final auth = Provider.of<AuthBase>(context, listen: false);
    chatController!.updateFirestoreData(
        FirestoreConstants.pathUserCollection,
        auth.currentUser!.uid,
        {FirestoreConstants.chattingWith: widget.reciever.id});
  }

  sendMessage() {
    final text = textEditingController.text.trim();

    final auth = Provider.of<AuthBase>(context, listen: false);

    final _senderId = auth.currentUser!.uid;

    final _message = Message(
        senderId: _senderId,
        recieverId: widget.reciever.id,
        message: text,
        timeStamp: DateTime.now().millisecondsSinceEpoch,
        type: 'text');

    widget.db.writeMessage(_message, auth.currentUser!, widget.reciever);
  }

  // @override
  // void initState() {
  //   secureScreen();
  //   // TODO: implement initState
  //   super.initState();
  // }

  @override
  void dispose() {
    clearSecureScreen();
    // TODO: implement dispose
    super.dispose();
  }

  Future getImage() async {
    ImagePicker imagePicker = ImagePicker();
    XFile? pickedFile;
    pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
      if (imageFile != null) {
        setState(() {
          isLoading = true;
        });
        uploadImageFile();
      }
    }
  }

  void uploadImageFile() async {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    UploadTask uploadTask =
        chatController!.uploadImageFile(imageFile!, fileName);
    try {
      TaskSnapshot snapshot = await uploadTask;
      imageUrl = await snapshot.ref.getDownloadURL();
      setState(() {
        isLoading = false;
        onSendMessage(imageUrl, MessageType.image);
      });
    } on FirebaseException catch (e) {
      setState(() {
        isLoading = false;
      });
      // Fluttertoast.showToast(msg: e.message ?? e.toString());
    }
  }

  void onSendMessage(String content, String type) {
    final auth = Provider.of<AuthBase>(context, listen: false);

    final _senderId = auth.currentUser!.uid;
    if (content.trim().isNotEmpty) {
      textEditingController.clear();
      chatController!.sendChatMessage(
          content, type, groupChatId, _senderId, widget.reciever.id);
      scrollController.animateTo(0,
          duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
    } else {
      // Fluttertoast.showToast(
      //     msg: 'Nothing to send', backgroundColor: Colors.grey);
    }
  }

  // bool isMessageReceived(int index) {
  //   if ((index > 0 &&
  //           listMessages[index - 1].get(FirestoreConstants.idFrom) ==
  //               currentUserId) ||
  //       index == 0) {
  //     return true;
  //   } else {
  //     return false;
  //   }
  // }

  // // checking if sent message
  // bool isMessageSent(int index) {
  //   if ((index > 0 &&
  //           listMessages[index - 1].get(FirestoreConstants.idFrom) !=
  //               currentUserId) ||
  //       index == 0) {
  //     return true;
  //   } else {
  //     return false;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);
    return Theme(
      data: Theme.of(context).copyWith(
          inputDecorationTheme: InputDecorationTheme(
            iconColor: Provider.of<ThemeNotifier>(context).darkTheme
                ? const Color(0xffF5F5F5)
                : const Color(0xff3D393A),
          ),
          colorScheme: ThemeData().colorScheme.copyWith(
                primary: Provider.of<ThemeNotifier>(context).darkTheme
                    ? const Color(0xffF5F5F5)
                    : const Color(0xff3D393A),
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
                children: [
                  const Icon(
                    Icons.arrow_back_ios_new_rounded,
                    size: 16,
                    color: Colors.pinkAccent,
                  ),
                  ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(25)),
                    child: Image.network(
                      widget.reciever.photoUrl ?? '',
                      height: 30,
                      width: 30,
                    ),
                  ),
                ],
              ),
            ),
            title: Text(
              widget.reciever.name,
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
        body: Column(
          children: [
            Expanded(
              flex: 5,
              child: StreamBuilder<List<Message>>(
                  stream: widget.db.messagesStream(
                      auth.currentUser!.uid, widget.reciever.id),
                  builder: (context, snapshot) {
                    return ListItemsBuilder<Message>(
                        controller: controller,
                        snapshot: snapshot,
                        itemBuilder: (context, message) => MessageBubble(
                              isSender:
                                  auth.currentUser!.uid == message.senderId,
                              text: message.message,
                              imageText: message.type == '1',
                            ));
                  }),
            ),
            const SizedBox(
              height: 10,
            ),
            _customTextField(context),
          ],
        ),
      ),
    );
  }

  Widget _customTextField(BuildContext context) {
    return SizedBox(
      height: 70,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
        child: TextField(
          style: TextStyle(
            color: Provider.of<ThemeNotifier>(context).darkTheme
                ? const Color(0xffF5F5F5)
                : const Color(0xff3D393A),
          ),
          cursorColor: Provider.of<ThemeNotifier>(context).darkTheme
              ? const Color(0xffF5F5F5)
              : const Color(0xff3D393A),
          controller: textEditingController,
          textInputAction: TextInputAction.newline,
          maxLines: null,
          expands: true,
          decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(2),
              iconColor: Provider.of<ThemeNotifier>(context).darkTheme
                  ? const Color(0xffF5F5F5)
                  : const Color(0xff3D393A),
              suffixIconColor: Provider.of<ThemeNotifier>(context).darkTheme
                  ? const Color(0xffF5F5F5)
                  : const Color(0xff3D393A),
              prefixIconColor: Provider.of<ThemeNotifier>(context).darkTheme
                  ? const Color(0xffF5F5F5)
                  : const Color(0xff3D393A),
              fillColor: Provider.of<ThemeNotifier>(context).darkTheme
                  ? const Color(0xff3D393A)
                  : const Color(0xffF5F5F5),
              filled: true,
              prefixIcon: IconButton(
                onPressed: getImage,
                icon: const Icon(
                  Icons.camera_alt,
                  size: Sizes.dimen_28,
                ),
              ),
              suffixIcon: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(onPressed: () {}, icon: const Icon(Icons.mic)),
                  IconButton(
                      onPressed: () {}, icon: const Icon(Icons.photo_outlined)),
                  IconButton(
                      onPressed: () async {
                        await sendMessage();
                        textEditingController.clear();
                        controller.animateTo(
                          controller.position.maxScrollExtent,
                          curve: Curves.easeOut,
                          duration: const Duration(milliseconds: 500),
                        );
                      },
                      icon: const Icon(Icons.send)),
                ],
              ),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide.none)),
        ),
      ),
    );
  }
}
