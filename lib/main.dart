import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:larning/cafes/cafe.dart';
import 'package:larning/home_screen.dart';
import 'package:larning/intro/anonymous_sign_in.dart';
import 'package:larning/intro/email_password_registration_sign_in.dart';
import 'package:larning/intro/google_sign_in.dart';
import 'package:larning/auth/login_screen.dart';
import 'package:larning/auth/register_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: FirebaseAuth.instance.currentUser != null ? '/Cafe' : '/Login',
      getPages: [
        GetPage(name: '/AnonymousSignIn', page: () => const AnonymousSignIn()),
        GetPage(name: '/EmailPasswordRegistrationSignIn', page: () => const EmailPasswordRegistrationSignIn()),
        GetPage(name: '/Google', page: () => const SocialAuthenticationGoogle()),
        GetPage(name: '/Login', page: () => LoginScreen()),
        GetPage(name: '/Register', page: () => RegisterScreen()),
        GetPage(name: '/Home', page: () => HomeScreen()),
        GetPage(name: '/Cafe', page: () => const Cafe()),
      ],
    );
  }
}
