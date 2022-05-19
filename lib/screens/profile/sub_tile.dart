import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:provider/provider.dart';
import 'package:privatechat/utils/themeNotifier.dart';

class SubTile extends StatefulWidget {
  final String title;
  const SubTile({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  State<SubTile> createState() => _SubTileState();
}

class _SubTileState extends State<SubTile> {
  bool status = false;
  @override
  Widget build(BuildContext context) {
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
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(
              widget.title,
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
              inactiveColor: Provider.of<ThemeNotifier>(context).darkTheme
                  ? Color(0xff201F24)
                  : Colors.white,
              inactiveToggleColor: Color(0xffFE9AAB),
              switchBorder: Border.all(color: Color(0xffFE9AAB)),
              width: 35.0,
              height: 20.0,
              toggleSize: 10.0,
              value: status,
              borderRadius: 20.0,
              onToggle: (val) {
                setState(() {
                  status = val;
                });
              },
            ),
            // IconButton(onPressed: (){
            // },icon: Icon(widget.iconData,color: Color(0xffFE9AAB),size: 35,),)
          ]),
        ],
      ),
    );
  }
}
