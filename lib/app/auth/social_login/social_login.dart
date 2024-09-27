import 'package:candian_cart/routes/app_pages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthenticationHelper {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  Future<void> googlebySignIn({required BuildContext context, token}) async {
    try {
      await googleSignIn.signOut(); // Sign out first if needed

      GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
      GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;

      AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken,
      );

      final result = await _auth.signInWithCredential(credential);
      User? user = result.user;

      // Extract necessary user information and use it
      debugPrint("Email: ${user?.email}");
      debugPrint("Name: ${user?.displayName}");
      debugPrint("UID: ${user?.uid}");
      debugPrint("Photo URL: ${user?.photoURL}");

      // Navigate to the home screen after successful sign-in
      Get.toNamed(Routes.homeScreenRoute);
    } catch (e) {
      print("Error during Google Sign-In: $e");
      Get.snackbar("Sign-In Error", "Failed to sign in with Google");
    }
  }
}
