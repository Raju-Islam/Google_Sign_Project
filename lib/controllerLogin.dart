// ignore_for_file: file_names, unnecessary_this

import 'package:flutter/material.dart';
import 'package:google_sign/userDetailsModel.dart';
import 'package:google_sign_in/google_sign_in.dart';

class ControllerLogin with ChangeNotifier {
  var googleSignInNow = GoogleSignIn();
  GoogleSignInAccount? googleSignInAccount;

  UserDetailsModel? userDetailsModel;

  allowUserToLogin() async {
    this.googleSignInAccount = await googleSignInNow.signIn();
    this.userDetailsModel = UserDetailsModel(
        displayName: googleSignInAccount!.displayName,
        email: googleSignInAccount!.email,
        photoURL: googleSignInAccount!.photoUrl);
    notifyListeners();
  }

  allowUserToLogout() async {
    this.googleSignInAccount = await googleSignInNow.signOut();
    userDetailsModel = null;

    notifyListeners();
  }
}
