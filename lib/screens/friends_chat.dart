import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:privatechat/screens/chat_screen.dart';
import 'package:privatechat/widgets/message_list_item.dart';

class FriendsChat extends StatelessWidget {
  const FriendsChat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: 20 + 1,
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return _topBar();
                      }
                      return MessageListItem(
                        onTap: () => ChatScreen.show(context),
                        friendName: 'friendName',
                        friendMessagePreview: 'friendMessagePreview',
                      );
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _topBar() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            // Your Friends
            Text("Your Friends",
                style: GoogleFonts.poppins(
                    color: const Color(0xff201f24),
                    fontSize: 32,
                    fontWeight: FontWeight.w500),
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
                  borderRadius: BorderRadius.all(Radius.circular(23.5)))),
        )
      ],
    );
  }
}
