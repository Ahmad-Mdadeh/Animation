import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:larning/home_screen.dart';
import 'package:rive/rive.dart';

class LoginController extends GetxController {
  SMIInput<bool>? isChecking;
  SMIInput<double>? numLook;
  SMIInput<bool>? isHandsUp;
  SMIInput<bool>? trigSuccess;
  SMIInput<bool>? trigFail;

  String? email;
  String? password;
  BuildContext? context;
  UserCredential? userCredential;

  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();

  @override
  void onInit() {
    emailFocusNode.addListener(emailFocus);
    passwordFocusNode.addListener(passwordFocus);
    super.onInit();
  }

  void emailFocus() {
    isChecking?.change(emailFocusNode.hasFocus);
  }

  void passwordFocus() {
    isHandsUp?.change(passwordFocusNode.hasFocus);
  }

  signIn() async {
    try {
       userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email!,
        password: password!,
      );
      trigSuccess?.change(true);
      await Future.delayed(
        const Duration(milliseconds: 2500),
      );
      Get.offAll(
        () =>  HomeScreen(),
        transition: Transition.fadeIn,
        duration: const Duration(
          milliseconds: 400,
        ),
      );
      return userCredential;
    } on FirebaseAuthException catch (e) {
      trigFail?.change(true);
      late String message;
      late String title = e.code.replaceAll(RegExp("-"), " ");
      if (e.code == 'user-not-found') {
        message = "User Not Found";
      } else if (e.code == 'wrong-password') {
        message = "Wrong Password";
      } else {
        message = e.code.replaceAll(RegExp("-"), " ");
      }
      AwesomeDialog(
        dialogType: DialogType.error,
        animType: AnimType.bottomSlide,
        context: context!,
        title: title,
        body: Container(
          padding: const EdgeInsets.only(
            bottom: 20.0,
          ),
          child: Text(message),
        ),
      ).show();
    }
  }

  User? get userProfile =>  FirebaseAuth.instance.currentUser;

}
