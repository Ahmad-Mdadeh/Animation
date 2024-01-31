import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AnonymousSignIn extends StatelessWidget {
  const AnonymousSignIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Authenticate with Firebase Anonymously"),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center, 
        children: [
          Center(
            child: ElevatedButton(
              onPressed: () async {
                try {
                  UserCredential userCredential =
                  await FirebaseAuth.instance.signInAnonymously();
                  print("Signed in with temporary account.");
                } on FirebaseAuthException catch (e) {
                  switch (e.code) {
                    case "operation-not-allowed":
                      print("Anonymous auth hasn't been enabled for this project.");
                      break;
                    default:
                      print("Unknown error.");
                  }
                }
              },
              child: const Text("Sign in"),
            ),
          ),
        ],
      ),
    );
  }
}
