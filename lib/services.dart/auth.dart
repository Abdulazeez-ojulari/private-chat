import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:privatechat/services.dart/api_path.dart';
import 'package:privatechat/services.dart/database.dart';
import 'package:privatechat/services.dart/firestore.dart';

abstract class AuthBase {
  Future<User?> signInWithGoogle();
  Stream<User?> authStateChanges();
  Future<void> signOut();
  User? get currentUser;
}

class Auth implements AuthBase {
  final _firebaseAuth = FirebaseAuth.instance;

  final _fireStore = FirebaseFirestore.instance;

  @override
  User? get currentUser => _firebaseAuth.currentUser;

  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
    final googleSignIn = GoogleSignIn();
    await googleSignIn.signOut();
  }

  @override
  Future<User?> signInWithGoogle() async {
    final _db = FirestorDatabase('');
    final googleSignIn = GoogleSignIn();
    final googleUser = await googleSignIn.signIn();
    if (googleUser != null) {
      final googleAuth = await googleUser.authentication;
      if (googleAuth.idToken != null) {
        final userCredential = await _firebaseAuth
            .signInWithCredential(GoogleAuthProvider.credential(
          idToken: googleAuth.idToken,
          accessToken: googleAuth.accessToken,
        ));

        final firebaseUser = userCredential.user;

        if(userCredential.additionalUserInfo!.isNewUser) {
          _db.createUserinDatabase(firebaseUser);
          // final QuerySnapshot result = await _fireStore
          //     .collection(APIPath.users)
          //     .where(APIPath.id, isEqualTo: firebaseUser.uid)
          //     .get();
          // final List<DocumentSnapshot> docs = result.docs;
          // if (docs.isEmpty) {
          //   _fireStore.collection(APIPath.users).doc(firebaseUser.uid).set({
          //     'displayName': firebaseUser.displayName,
          //     'photoUrl': firebaseUser.photoURL,
          //     'id': firebaseUser.uid,
          //     'createdAt': DateTime.now().millisecondsSinceEpoch.toString(),
          //     'chattingWith': null,
          //     'email': firebaseUser.email
          //   });
          // }
        }

        return userCredential.user;
      } else {
        throw FirebaseAuthException(
            code: 'ERROR_MISSING_GOOGLE_IDTOKEN',
            message: 'Missing Google IDtoken');
      }
    } else {
      throw FirebaseAuthException(
          code: 'ERROR_ABORTED_BY_USER', message: 'Sign In aborted by user');
    }
  }

  @override
  Stream<User?> authStateChanges() => _firebaseAuth.authStateChanges();
}
