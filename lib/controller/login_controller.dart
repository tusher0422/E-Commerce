import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import '/screens/home_screen.dart';

class LoginController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Rxn<User> firebaseUser = Rxn<User>();

  Future<void> signInWithGoogle() async {
    try {
      EasyLoading.show(status: 'Signing in...');

      if (kIsWeb) {

        final GoogleAuthProvider googleProvider = GoogleAuthProvider();
        googleProvider.setCustomParameters({'prompt': 'select_account'});

        final UserCredential userCredential =
        await _auth.signInWithPopup(googleProvider);
        firebaseUser.value = userCredential.user;
      } else {

        final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
        if (googleUser == null) {
          EasyLoading.dismiss();
          return;
        }

        final googleAuth = await googleUser.authentication;
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        final userCredential =
        await _auth.signInWithCredential(credential);
        firebaseUser.value = userCredential.user;
      }

      EasyLoading.dismiss();
      Get.offAll(() => HomeScreen());
    } catch (e) {
      EasyLoading.showError('Login Failed: $e');
      print('Login error: $e');
    }
  }
}
