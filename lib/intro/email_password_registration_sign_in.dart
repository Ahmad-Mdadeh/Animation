import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EmailPasswordRegistrationSignIn extends StatelessWidget {
  const EmailPasswordRegistrationSignIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Email/Password Registration & Sign-in"),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ///////////////// Registration /////////////////
          Center(
            child: ElevatedButton(
              onPressed: () async {
                try {
                  UserCredential userCredential = await FirebaseAuth.instance
                      .createUserWithEmailAndPassword(
                          email: "abowatan.it@gmail.com",
                          password: "SuperSecretPassword!");

                  ////////////// Verifying a users email //////////////
                  User? user = FirebaseAuth.instance.currentUser;
                  if (user != null && !user.emailVerified) {
                    await user.sendEmailVerification();
                  }
                } on FirebaseAuthException catch (e) {
                  if (e.code == 'weak-password') {
                    print('The password provided is too weak.');
                  } else if (e.code == 'email-already-in-use') {
                    print('The account already exists for that email.');
                  }
                } catch (e) {
                  print(e);
                }
              },
              child: const Text("Registration"),
            ),
          ),
          ///////////////// Sign-in /////////////////
          Center(
            child: ElevatedButton(
              onPressed: () async {
                try {
                  UserCredential userCredential =
                      await FirebaseAuth.instance.signInWithEmailAndPassword(
                    email: "abowatan.it@gmail.com",
                    password: "SuperSecretPassword!",
                  );
                  Get.snackbar(
                    "Success",
                    "Sign-in",
                    snackPosition: SnackPosition.BOTTOM,
                  );
                  print(
                    userCredential.user!.emailVerified,
                  );
                } on FirebaseAuthException catch (e) {
                  if (e.code == 'user-not-found') {
                    print('No user found for that email.');
                  } else if (e.code == 'wrong-password') {
                    print('Wrong password provided for that user.');
                  }
                }
              },
              child: const Text("Sign-in"),
            ),
          ),
        ],
      ),
    );
  }
}
