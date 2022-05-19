import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:provider/provider.dart';
import 'package:privatechat/utils/themeNotifier.dart';

class SubTile extends StatefulWidget {
  final String title;
  final void Function(bool) onToggle;
  final bool value;
  const SubTile({
    Key? key,
    required this.title,
    required this.onToggle, required this.value,
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
                  inactiveToggleColor:  Provider.of<ThemeNotifier>(context).darkTheme
                      ? Colors.white
                      : Color(0xffFE9AAB),
                  switchBorder: Border.all(color: Color(0xffFE9AAB)),
                  width: 35.0,
                  height: 20.0,
                  toggleSize: 10.0,
                  value: widget.value,
                  borderRadius: 20.0,
                  onToggle: (val) => widget.onToggle(val),
            )]
              
            ),
            // IconButton(onPressed: (){
            // },icon: Icon(widget.iconData,color: Color(0xffFE9AAB),size: 35,),)
          ]),
        
      );
    
  }
}
