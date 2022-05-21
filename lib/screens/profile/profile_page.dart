import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:privatechat/screens/profile/sub_tile.dart';
import 'package:privatechat/controllers/themeNotifier.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final CupertinoTabController? controller = CupertinoTabController();
  bool status = false;
  
  @override
  Widget build(BuildContext context) {
    final darkTheme = Provider.of<ThemeNotifier>(context).darkTheme ;
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
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: darkTheme ? Colors.white : Colors.black),
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
                    style: TextStyle(fontSize: 12, color: darkTheme ? Colors.white : Colors.black),
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
                  Text("About me",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: darkTheme ? Colors.white : Colors.black)),
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
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: darkTheme ? Colors.white : Colors.black)),
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
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: darkTheme ? Colors.white : Colors.black)),
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
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: darkTheme ? Colors.white : Colors.black)),
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
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: darkTheme ? Colors.white : Colors.black)),
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
                onToggle: (val) { Provider.of<ThemeNotifier>(
                  context, listen: false
                ).darkTheme = val;
                
                }
              ),
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
            ],
          ),
        ),
      ),
    );
  }
}
