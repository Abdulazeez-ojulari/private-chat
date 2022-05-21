import 'package:flutter/material.dart';
import 'package:privatechat/controllers/signinpage_controller.dart';
import 'package:privatechat/services.dart/auth.dart';
import 'package:privatechat/controllers/themeNotifier.dart';
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
      backgroundColor: Provider.of<ThemeNotifier>(context).darkTheme
          ? const Color(0xff201F24)
          : const Color(0xfff1f1f1),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    isLoading
                        ? Center(
                            child: CircularProgressIndicator(
                              color:
                                  Provider.of<ThemeNotifier>(context).darkTheme
                                      ? Colors.white
                                      : Colors.black,
                            ),
                          )
                        : Text(
                            'Private.Chat',
                            style: GoogleFonts.poppins(
                              fontSize: 30,
                              fontWeight: FontWeight.w600,
                              color:
                                  Provider.of<ThemeNotifier>(context).darkTheme
                                      ? Colors.white
                                      : Colors.black,
                            ),
                            textAlign: TextAlign.center,
                          ),
                    const SizedBox(height: 12),
                    Text(
                      'But I must explain to you how all this mistaken idea of.',
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        color: Provider.of<ThemeNotifier>(context).darkTheme
                            ? Colors.white
                            : Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
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
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: Provider.of<ThemeNotifier>(context).darkTheme
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      minimumSize: Size.zero,
                      padding: EdgeInsets.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    onPressed: () {
                      debugPrint('tapped');
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
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: Provider.of<ThemeNotifier>(context).darkTheme
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        minimumSize: Size.zero,
                        padding: EdgeInsets.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      onPressed: () {
                        debugPrint('tapped');
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
