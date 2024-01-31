import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:larning/home_screen.dart';

class RegisterController extends GetxController {
  String userName = "";
  String? email;
  String? password;
  BuildContext? context;

  signUp() async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: email!,
            password: password!,
          )
          .then(
            (value) =>
                FirebaseAuth.instance.currentUser!.updateDisplayName(userName),
          );
      Get.offAll(
        () => HomeScreen(),
        transition: Transition.fadeIn,
        duration: const Duration(
          milliseconds: 400,
        ),
      );
    } on FirebaseAuthException catch (e) {
      late String message;
      late String title = e.code.replaceAll(RegExp("-"), " ");
      if (e.code == 'weak-password') {
        message = "The password provided is too weak.";
      } else if (e.code == 'email-already-in-use') {
        message = "The account already exists for that email.";
      } else {
        message = 'Ops!..please try again';
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
    } catch (e) {
      Get.snackbar(
        "Error ! ",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
