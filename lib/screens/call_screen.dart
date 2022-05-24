import 'package:flutter/material.dart';
import 'package:privatechat/controllers/themeNotifier.dart';
import 'package:provider/provider.dart';

class CallScreen extends StatefulWidget {
  const CallScreen({Key? key}) : super(key: key);

  @override
  State<CallScreen> createState() => _CallScreenState();
}

bool speakerButtonPressed = false;
bool micButtonPressed = false;
bool holdButtonPressed = false;

class _CallScreenState extends State<CallScreen> {
  @override
  Widget build(BuildContext context) {
    final darkTheme = Provider.of<ThemeNotifier>(context).darkTheme;
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xff201F24),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: const [
                Image(
                  height: 300,
                  width: 200,
                  image: AssetImage('images/avatar.png'),
                ),
                Text(
                  'Anonymous #3245',
                  style: TextStyle(fontSize: 25, color: Color(0xffFE9AAB)),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: width * 0.15, vertical: 5),
                    width: width,
                    height: height * 0.1,
                    color: Color(0xff201F24),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: CircleBorder(),
                                primary: speakerButtonPressed
                                    ? Colors.white
                                    : Color(0xff201F24),
                              ),
                              onPressed: () {
                                setState(() {
                                  speakerButtonPressed = !speakerButtonPressed;
                                });
                              },
                              child: Icon(
                                Icons.volume_up,
                                color: Color(0xffFE9AAB),
                                size: width * 0.06,
                              ),
                            ),
                            Text(
                              'Speaker',
                              style: TextStyle(
                                fontSize: 10,
                                color: Color(0xffFE9AAB),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Color(0xff201F24),
                                shape: const CircleBorder(),
                              ),
                              onPressed: () {
                                setState(() {
                                  micButtonPressed = !micButtonPressed;
                                });
                              },
                              child: Icon(
                                micButtonPressed ? Icons.mic_off : Icons.mic,
                                color: Color(0xffFE9AAB),
                                size: width * 0.06,
                              ),
                            ),
                            const Text(
                              'Mic',
                              style: TextStyle(
                                fontSize: 10,
                                color: Color(0xffFE9AAB),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: holdButtonPressed
                                    ? Colors.white
                                    : Color(0xff201F24),
                                shape: const CircleBorder(),
                              ),
                              onPressed: () {
                                setState(() {
                                  holdButtonPressed = !holdButtonPressed;
                                });
                              },
                              child: Icon(
                                Icons.pause,
                                color: Color(0xffFE9AAB),
                                size: width * 0.06,
                              ),
                            ),
                            Text(
                              'Hold',
                              style: TextStyle(
                                  fontSize: 10, color: Color(0xffFE9AAB)),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Colors.red,
                                shape: const CircleBorder(),
                              ),
                              onPressed: () {},
                              child: Icon(
                                Icons.phone,
                                color: Colors.white,
                                size: width * 0.06,
                              ),
                            ),
                            Text(
                              'End Call',
                              style: TextStyle(
                                  fontSize: 10, color: Color(0xffFE9AAB)),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
