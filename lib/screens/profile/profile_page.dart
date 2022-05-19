import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:privatechat/screens/profile/sub_tile.dart';
import 'package:privatechat/utils/themeNotifier.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool status = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Profile",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        backgroundColor:
                            Provider.of<ThemeNotifier>(context).darkTheme
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
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                      subtitle: Row(
                        children: [
                          Container(
                            width: 20,
                            height: 20,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 7,
                          ),
                          Container(
                            width: 20,
                            height: 20,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 7,
                          ),
                          Container(
                            width: 20,
                            height: 20,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 7,
                          ),
                          Container(
                            width: 20,
                            height: 20,
                            color: Colors.white,
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
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("About me",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600)),
                    IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.edit,
                          color: Colors.grey,
                        ))
                  ],
                ),
                Text(
                  "Lorem ipsum dolor sit amet conseteur sodioscing etitr\n"
                  "sed diam nonumy eirmod tempor invidunt ut labore et\n"
                  "dolore magna ajiquyam erat, sed diam volptuo. At vero\n"
                  "eos et",
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
                            fontSize: 18, fontWeight: FontWeight.w600)),
                    IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.add_location,
                          color: Color(0xffFE9AAB),
                        ))
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
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
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
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
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
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                SizedBox(
                  height: 15,
                ),
                Divider(
                  height: 2,
                  color: Colors.black,
                ),
                SubTile(
                  title: "Hide Online",
                ),
                Consumer(
                  builder: (context, ThemeNotifier themeNotifier, child) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Column(
                        children: [
                          Divider(
                            height: 2,
                            color: Colors.grey,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Dark mode',
                                  style: TextStyle(
                                      color: Color(0xffFE9AAB),
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                FlutterSwitch(
                                  activeColor: Color(0xffFE9AAB),
                                  inactiveColor: themeNotifier.darkTheme
                                      ? Color(0xff201F24)
                                      : Colors.white,
                                  inactiveToggleColor: Color(0xffFE9AAB),
                                  switchBorder:
                                      Border.all(color: Color(0xffFE9AAB)),
                                  width: 35.0,
                                  height: 20.0,
                                  toggleSize: 10.0,
                                  value: status,
                                  borderRadius: 20.0,
                                  onToggle: (val) {
                                    setState(() {
                                      status = val;
                                      themeNotifier.toggleTheme();
                                    });
                                  },
                                ),
                              ]),
                        ],
                      ),
                    );
                  },
                ),
                SubTile(
                  title: "Phone Vibration",
                ),
                SubTile(
                  title: "Notification",
                ),
                SubTile(
                  title: "Show Online",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
