import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:privatechat/screens/profile/sub_tile.dart';
import 'package:privatechat/controllers/themeNotifier.dart';
import 'package:provider/provider.dart';
import 'package:privatechat/screens/profile/subTileWihoutSwitch.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final CupertinoTabController? controller = CupertinoTabController();
  bool status = false;
  TextEditingController aboutMeTextEditingController = TextEditingController();
  String aboutMe = '';
  @override
  Widget build(BuildContext context) {
    final darkTheme = Provider.of<ThemeNotifier>(context).darkTheme;
    return Scaffold(
      backgroundColor: darkTheme ? Color(0xff201f24) : Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Profile",
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: darkTheme ? Colors.white : Colors.black),
              ),
              SizedBox(
                height: 10,
              ),
              ListTile(
                leading: CircleAvatar(
                  backgroundColor: Provider.of<ThemeNotifier>(context).darkTheme
                      ? Color(0xff201F24)
                      : Color(0xfff1f1f1),
                  child: Image.asset(
                    "images/avatar.png",
                    height: 50,
                    width: 50,
                    alignment: Alignment.centerLeft,
                  ),
                ),
                title: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    "Anonymous #2353",
                    style: TextStyle(
                        fontSize: 12,
                        color: darkTheme ? Colors.white : Colors.black),
                  ),
                ),
                subtitle: Row(
                  children: [
                    Container(
                      width: 20,
                      height: 20,
                      color: darkTheme ? Colors.white : Colors.black,
                    ),
                    SizedBox(
                      width: 7,
                    ),
                    Container(
                      width: 20,
                      height: 20,
                      color: darkTheme ? Colors.white : Colors.black,
                    ),
                    SizedBox(
                      width: 7,
                    ),
                    Container(
                      width: 20,
                      height: 20,
                      color: darkTheme ? Colors.white : Colors.black,
                    ),
                    SizedBox(
                      width: 7,
                    ),
                    Container(
                      width: 20,
                      height: 20,
                      color: darkTheme ? Colors.white : Colors.black,
                    )
                  ],
                ),
                trailing: IconButton(
                  padding: EdgeInsets.only(left: 25),
                  onPressed: () {},
                  icon: Icon(
                    Icons.edit,
                    color: Colors.grey,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "About me",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: darkTheme ? Colors.white : Colors.black,
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        showModalBottomSheet(
                            enableDrag: true,
                            isDismissible: true,
                            useRootNavigator: true,
                            backgroundColor: Colors.transparent,
                            context: context,
                            builder: (context) {
                              return Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.3,
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: darkTheme
                                      ? Color(0xff201F24)
                                      : Color(0xfff1f1f1),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                  ),
                                ),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      TextField(
                                        scrollPhysics: BouncingScrollPhysics(),
                                        cursorColor: const Color(0xffff647c),
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w400),
                                        controller:
                                            aboutMeTextEditingController,
                                        decoration: const InputDecoration(
                                          fillColor: Color(0xffdedede),
                                          filled: true,
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.transparent,
                                                width: 0),
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(22.5),
                                            ),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.transparent,
                                                width: 0),
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(23.5),
                                            ),
                                          ),
                                          disabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.transparent,
                                                width: 0),
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(23.5),
                                            ),
                                          ),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(23.5),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 30),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          ElevatedButton(
                                            style: Theme.of(context)
                                                .elevatedButtonTheme
                                                .style,
                                            onPressed: () {
                                              setState(() {
                                                aboutMeTextEditingController
                                                    .clear();
                                                aboutMe =
                                                    aboutMeTextEditingController
                                                        .text;
                                                Navigator.pop(context);
                                              });
                                            },
                                            child: const Text('Clear'),
                                          ),
                                          const SizedBox(width: 20),
                                          ElevatedButton(
                                            onPressed: () {
                                              setState(() {
                                                aboutMe =
                                                    aboutMeTextEditingController
                                                        .text;
                                                Navigator.pop(context);
                                              });
                                            },
                                            child: const Text('Save'),
                                          ),
                                        ],
                                      ),
                                    ]),
                              );
                            });
                      },
                      icon: Icon(
                        Icons.edit,
                        color: Colors.grey,
                      ))
                ],
              ),
              Text(
                aboutMe == '' ? 'Write a few lines about you' : aboutMe,
                style: TextStyle(
                  fontSize: 13,
                  color: Color(0xffFE9AAB),
                  fontWeight: FontWeight.normal,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Location",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: darkTheme ? Colors.white : Colors.black)),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.add_location,
                      color: Color(0xffFE9AAB),
                    ),
                  ),
                ],
              ),
              Text("Jaipur, Rajastan",
                  style: TextStyle(
                      fontSize: 13,
                      color: Color(0xffFE9AAB),
                      fontWeight: FontWeight.normal)),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 10,
              ),
              Text("Gender",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: darkTheme ? Colors.white : Colors.black)),
              SizedBox(
                height: 10,
              ),
              Text("Male",
                  style: TextStyle(
                      fontSize: 13,
                      color: Color(0xffFE9AAB),
                      fontWeight: FontWeight.normal)),
              SizedBox(
                height: 10,
              ),
              Text("Sexuality",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: darkTheme ? Colors.white : Colors.black)),
              SizedBox(
                height: 10,
              ),
              Text("Heterosexual",
                  style: TextStyle(
                      fontSize: 13,
                      color: Color(0xffFE9AAB),
                      fontWeight: FontWeight.normal)),
              SizedBox(
                height: 30,
              ),
              Text("Subscription",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: darkTheme ? Colors.white : Colors.black)),
              SizedBox(
                height: 15,
              ),
              Divider(
                height: 2,
                color: Colors.black,
              ),
              SubTile(
                title: "Hide Online",
                onToggle: (val) {},
                value: Provider.of<ThemeNotifier>(
                  context,
                ).status1,
              ),
              SubTile(
                  title: 'Dark mode',
                  value: Provider.of<ThemeNotifier>(
                    context,
                  ).status2,
                  onToggle: (val) {
                    Provider.of<ThemeNotifier>(context, listen: false)
                        .darkTheme = val;
                  }),
              SubTile(
                value: Provider.of<ThemeNotifier>(
                  context,
                ).status3,
                title: "Phone Vibration",
                onToggle: (val) {},
              ),
              SubTile(
                title: "Notification",
                onToggle: (val) {},
                value: Provider.of<ThemeNotifier>(
                  context,
                ).status4,
              ),
              SubTile(
                title: "Show Online",
                onToggle: (val) {},
                value: Provider.of<ThemeNotifier>(
                  context,
                ).status5,
              ),
              SubTile_withoutSwitch(title: 'Block Management'),
              SubTile_withoutSwitch(title: 'Scratch Card'),
              SubTile_withoutSwitch(title: 'Referral'),
              SubTile_withoutSwitch(title: 'Rating'),
              SubTile_withoutSwitch(title: 'About us'),
              SubTile_withoutSwitch(title: 'FAQ'),
              SubTile_withoutSwitch(title: 'T&C Privacy Policy'),
            ],
          ),
        ),
      ),
    );
  }
}
