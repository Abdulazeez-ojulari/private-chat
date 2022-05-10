import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:privatechat/services.dart/auth.dart';
import 'package:provider/provider.dart';
import 'package:privatechat/widgets/preferences/preference_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  Future<void> _signOut(BuildContext context) async {
    final auth = Provider.of<AuthBase>(context, listen: false);
    try {
      await auth.signOut();
    } on FirebaseException catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: 500,
                alignment: Alignment.center,
                child: const Image(
                  image: AssetImage('images/Layer_2.png'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: const Color(0xffff647c),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(22.5)),
                      )),
                  onPressed: () {
                    //TODO: Screen to take user to.
                  },
                  child: Row(
                    children: [
                      const Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                        child: FaIcon(
                          FontAwesomeIcons.solidComments,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 45.0),
                        child: Text(
                          'Start Chatting',
                          style: GoogleFonts.poppins(
                              fontSize: 20, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 27,
              ),
              GestureDetector(
                onTap: () {
                  //Show modalBottomSheet of Preference settings.
                  showModalBottomSheet(
                      backgroundColor: Colors.transparent,
                      isScrollControlled: true,
                      isDismissible: true,
                      enableDrag: true,
                      context: context,
                      builder: (context) {
                        return PreferenceWidget();
                      });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Search preferences',
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: const Color(0xffff647c),
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    const FaIcon(
                      FontAwesomeIcons.sliders,
                      size: 10,
                      color: const Color(0xffff647c),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
