import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:privatechat/models/user.dart';
import 'package:privatechat/screens/chat_screen.dart';
import 'package:privatechat/services.dart/auth.dart';
import 'package:privatechat/services.dart/database.dart';
import 'package:privatechat/controllers/themeNotifier.dart';
import 'package:privatechat/widgets/list_item_builder.dart';
import 'package:privatechat/widgets/message_list_item.dart';
import 'package:provider/provider.dart';

class FriendsChat extends StatefulWidget {
  const FriendsChat({Key? key}) : super(key: key);

  @override
  State<FriendsChat> createState() => _FriendsChatState();
}

class _FriendsChatState extends State<FriendsChat> {
  List<UserModel> userList = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final darkTheme = Provider.of<ThemeNotifier>(context).darkTheme;

    TextEditingController textEditingController = TextEditingController();
    final controller = ScrollController();

    final db = Provider.of<DataBase>(context, listen: false);
    final auth = Provider.of<AuthBase>(context, listen: false);
    return Scaffold(
      backgroundColor: darkTheme ? const Color(0xff201f24) : Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: darkTheme ? const Color(0xff201f24) : Colors.white,
        title: Text("Your Friends",
            style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: darkTheme ? Colors.white : Colors.black),
            textAlign: TextAlign.left),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications),
            iconSize: 30,
            color: const Color(0xfffe9aab),
          )
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(70),
          child: _searchField(textEditingController),
        ),
      ),
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: StreamBuilder<List<UserModel>>(
                  stream: db.usersStream(auth.currentUser!),
                  builder: (context, snapshot) {
                    return ListItemsBuilder<UserModel>(
                        controller: controller,
                        snapshot: snapshot,
                        itemBuilder: (context, userModel) => MessageListItem(
                              friendName: userModel.name,
                              friendMessagePreview: userModel.email,
                              friendImage: userModel.photoUrl,
                              onTap: () =>
                                  ChatScreen.show(context, db, userModel),
                              textColor:
                                  darkTheme ? Colors.white : Colors.black,
                            ));
                    // ListView.builder(
                    //     padding:
                    //         const EdgeInsets.only(left: 8.0, right: 8.0, top: 10),
                    //     physics: const BouncingScrollPhysics(),
                    //     itemCount: list?.length ?? 10,
                    //     itemBuilder: (context, index) {
                    //       if (index == 0) {
                    //         return _topBar(darkTheme);
                    //       }
                    //       return MessageListItem(
                    //         onTap: () => ChatScreen.show(context, db),
                    //         friendName: list?[index].name ?? 'nawa',
                    //         friendMessagePreview: list?[index].email ?? 'nawa',
                    //         friendImage: list?[index].photoUrl,
                    //         textColor: darkTheme ? Colors.white : Colors.black,
                    //       );
                    //     });
                  }),
            )
          ],
        ),
      ),
    );
  }

  Widget _searchField(TextEditingController textEditingController) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: textEditingController,
        decoration: InputDecoration(
          fillColor: const Color(0xffdedede),
          filled: true,
          prefixIcon: const Icon(
            Icons.search_rounded,
            size: 30,
          ),
          hintText: 'Type something...',
          hintStyle:
              GoogleFonts.poppins(color: const Color(0xff6d6d6d), fontSize: 14),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent, width: 0),
            borderRadius: BorderRadius.all(
              Radius.circular(23.5),
            ),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent, width: 0),
            borderRadius: BorderRadius.all(
              Radius.circular(23.5),
            ),
          ),
          disabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent, width: 0),
            borderRadius: BorderRadius.all(
              Radius.circular(23.5),
            ),
          ),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(23.5),
            ),
          ),
        ),
      ),
    );
  }

  Widget _topBar(darkTheme) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            // Your Friends
            Text("Your Friends",
                style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: darkTheme ? Colors.white : Colors.black),
                textAlign: TextAlign.left),
            const Spacer(),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.notifications),
              iconSize: 30,
              color: const Color(0xfffe9aab),
            )
          ],
        ),
        const SizedBox(
          height: 12,
        ),
        TextField(
          decoration: InputDecoration(
            fillColor: const Color(0xffdedede),
            filled: true,
            prefixIcon: const Icon(
              Icons.search_rounded,
              size: 30,
            ),
            hintText: 'Type something...',
            hintStyle: GoogleFonts.poppins(
                color: const Color(0xff6d6d6d), fontSize: 14),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent, width: 0),
              borderRadius: BorderRadius.all(
                Radius.circular(23.5),
              ),
            ),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent, width: 0),
              borderRadius: BorderRadius.all(
                Radius.circular(23.5),
              ),
            ),
            disabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent, width: 0),
              borderRadius: BorderRadius.all(
                Radius.circular(23.5),
              ),
            ),
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(23.5),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
