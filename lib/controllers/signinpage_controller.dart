import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:privatechat/services.dart/auth.dart';

class SignInController with ChangeNotifier {
  SignInController({
    required this.auth,
    this.isLoading = false,
  });
  final AuthBase auth;
  bool isLoading;

  void _setIsLoading(bool _isLoading) {
    isLoading = _isLoading;
    notifyListeners();
  }

  Future<User?> _signIn(
      {required Future<User?> Function() signInMethod}) async {
    try {
      _setIsLoading(true);
      return await signInMethod();
    } catch (e) {
      _setIsLoading(false);
      rethrow;
    }
  }

  bool isCurrentUser() {
    if (auth.currentUser?.uid == null) {
      return false;
    }
    return true;
  }

  Future<User?> signInWithGoogle() async =>
      await _signIn(signInMethod: auth.signInWithGoogle);
}
