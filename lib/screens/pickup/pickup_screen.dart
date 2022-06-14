import 'package:flutter/material.dart';
import 'package:privatechat/controllers/call.controller.dart';
import 'package:privatechat/models/call.dart';
import 'package:privatechat/screens/call_screen.dart';
import 'package:privatechat/utils/permissions.dart';

class PickupScreen extends StatelessWidget {
  final Call call;
  final CallController callController = CallController();

  PickupScreen({
    required this.call,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 100),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              "Incoming...",
              style: TextStyle(
                fontSize: 30,
              ),
            ),
            const SizedBox(height: 50),
            Image.network(
              call.callerPic ?? '',
              height: 300,
              width: 200,
            ),
            const SizedBox(height: 15),
            Text(
              call.callerName ?? '',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                IconButton(
                  icon: const Icon(Icons.call_end),
                  color: Colors.redAccent,
                  onPressed: () async {
                    await callController.endCall(call: call);
                  },
                ),
                const SizedBox(width: 25),
                IconButton(
                  icon: const Icon(Icons.call),
                  color: Colors.green,
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CallScreen(call: call),
                    ),
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
