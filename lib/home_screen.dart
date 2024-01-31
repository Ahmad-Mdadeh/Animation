import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:larning/home_controller.dart';
import 'package:larning/auth/login_controller.dart';
import 'package:larning/auth/login_screen.dart';
import 'package:larning/utils/app_color.dart';
import 'package:larning/utils/text_utils.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  final loginController = Get.put(LoginController());
  final homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD6E2EA),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1C3E66),
        title: const Text("Login"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 100.0,
                  height: 100.0,
                  decoration: BoxDecoration(
                    color: AppColor.white,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(
                  width: 15.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 24.0,),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextUtils(
                        text: loginController.userProfile!.displayName!,
                        color: Colors.black,
                        fontWeight: FontWeight.w300,
                        fontSize: 18.0,
                      ),
                      TextUtils(
                        text: loginController.userProfile!.email!,
                        color: Colors.black,
                        fontWeight: FontWeight.w300,
                        fontSize: 18.0,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 200,),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1C3E66),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                Get.offAll(() => LoginScreen());
              },
              child: const Text(
                "Sign Out",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1C3E66),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              onPressed: () async {
               await homeController.addUser();
              },
              child: const Text(
                "FireStore",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            
          ],
        ),
      ),
    );
  }
}
