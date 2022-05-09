import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:privatechat/controllers/signinpage_controller.dart';
import 'package:privatechat/services.dart/auth.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

class SignInPage extends StatelessWidget {
  const SignInPage(
      {Key? key, required this.controller, required this.isLoading})
      : super(key: key);
  final SignInController controller;
  final bool isLoading;

  static Widget create(BuildContext context) {
    final auth = Provider.of<AuthBase>(context);
    return ChangeNotifierProvider<SignInController>(
      create: (_) => SignInController(
        auth: auth,
      ),
      child: Consumer<SignInController>(
          builder: (_, controller, __) => SignInPage(
                controller: controller,
                isLoading: controller.isLoading,
              )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    isLoading
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : Text(
                            'Private.Chat',
                            style: GoogleFonts.poppins(
                              fontSize: 30,
                              fontWeight: FontWeight.w600,
                            ),
                            textAlign: TextAlign.center,
                          ),
                    SizedBox(height: 12),
                    Text(
                      'But I must explain to you how all this mistaken idea of.',
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 100,
                    ),
                    SizedBox(
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: const Color(0xffff647c),
                            shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(22.5)),
                            )),
                        onPressed: () {
                          controller.signInWithGoogle();
                          
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 27),
                              child: Image(
                                fit: BoxFit.fill,
                                image: AssetImage('images/google_logo.png'),
                              ),
                            ),
                            Text(
                              'Sign In With Google',
                              style: GoogleFonts.poppins(
                                  fontSize: 20, fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '"I accepted the ',
                    style: GoogleFonts.poppins(fontSize: 12),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      minimumSize: Size.zero,
                      padding: EdgeInsets.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    onPressed: () {
                      print('tapped');
                    },
                    child: Text(
                      'Terms of services."',
                      style: GoogleFonts.poppins(fontSize: 12),
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'and "I accept the ',
                      style: GoogleFonts.poppins(fontSize: 12),
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        minimumSize: Size.zero,
                        padding: EdgeInsets.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      onPressed: () {
                        print('tapped');
                      },
                      child: Text(
                        'Privacy Statement."',
                        style: GoogleFonts.poppins(fontSize: 12),
                      ),
                    )
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
