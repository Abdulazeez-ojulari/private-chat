import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:privatechat/controllers/call.controller.dart';
import 'package:privatechat/models/call.dart';
import 'package:privatechat/screens/pickup/pickup_screen.dart';
import 'package:privatechat/services.dart/auth.dart';
import 'package:provider/provider.dart';

class PickupLayout extends StatelessWidget {
  final Widget scaffold;
  final CallController callController = CallController();

  PickupLayout({
    required this.scaffold,
  });

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);

    return (auth.currentUser != null)
        ? StreamBuilder<DocumentSnapshot>(
            stream: callController.callStream(uid: auth.currentUser!.uid),
            builder: (context, snapshot) {
              if (snapshot.hasData &&
                  snapshot.data!.data().toString().isNotEmpty) {
                if (snapshot.data!.data() != null) {
                  final Map<dynamic, dynamic> doc =
                      snapshot.data!.data() as Map<dynamic, dynamic>;
                  Call call = Call.fromMap(doc);

                  if (call.hasDialled != null && call.hasDialled != true) {
                    return PickupScreen(call: call);
                  }
                }
              }
              return scaffold;
            },
          )
        : const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
  }
}
