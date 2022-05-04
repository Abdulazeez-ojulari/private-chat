import 'package:flutter/material.dart';
import 'package:privatechat/controllers/signinpage_controller.dart';
import 'package:privatechat/services.dart/auth.dart';
import 'package:provider/provider.dart';

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
      appBar: AppBar(
        title: const Text(
          'Private.Chat',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : const Center(
                      child: Text(
                        'Sign In',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
              const SizedBox(
                height: 40,
              ),
              SizedBox(
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: const Color(0xffff647c),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(22.5)),
                      )),
                  onPressed: () {
                    controller.signInWithGoogle();
                  },
                  child: const Text('Sign In With Google'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
