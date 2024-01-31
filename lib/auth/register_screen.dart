import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:larning/auth/login_screen.dart';
import 'package:larning/auth/register_controller.dart';
import 'package:larning/utils/custom_textField.dart';
import 'package:larning/utils/reg_exp.dart';
import 'package:larning/utils/text_utils.dart';

String email="";

String userName="";

String password="";

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);
  final registerController = Get.put(RegisterController());
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
    Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Scaffold(
        backgroundColor: const Color(0xFFD6E2EA),
        appBar: AppBar(
          backgroundColor: const Color(0xFF1C3E66),
          title: const Text("Register"),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(
              top: 160.0,
            ),
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: MediaQuery.of(context).size.height * 0.4,
                  padding: const EdgeInsets.only(
                    left: 16.0,
                    right: 16.0,
                    top: 25.0,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: [
                      CustomTextField(
                        size: MediaQuery.of(context).size,
                        function: (value) {
                          userName = value;
                        },
                        hintText: "User Name",
                        prefix: Icons.person,
                        type: TextInputType.name,
                        validator: (value) {
                          if (!RegExp(validationName).hasMatch(value)) {
                            return "Invalid userName";
                          } else {
                            return null;
                          }
                        },
                      ),
                      CustomTextField(
                        size: MediaQuery.of(context).size,
                        function: (value) {
                          email = value;
                        },
                        hintText: "Email",
                        prefix: Icons.email,
                        type: TextInputType.emailAddress,
                        validator: (value) {
                          if (!RegExp(validationEmail).hasMatch(value)) {
                            return "Invalid Email";
                          } else {
                            return null;
                          }
                        },
                      ),
                      CustomTextField(
                        size: MediaQuery.of(context).size,
                        obscureText: true,
                        function: (value) {
                          password = value;
                        },
                        hintText: "Password",
                        prefix: Icons.key_outlined,
                        suffix: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.visibility,
                            color: Colors.grey,
                          ),
                        ),
                        type: TextInputType.visiblePassword,
                        validator: (value) {
                          if (value.toString().length < 8) {
                            return "Invalid password";
                          } else {
                            return null;
                          }
                        },
                      ),
                      const SizedBox(
                        height: 45.0,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.055,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF1C3E66),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          onPressed: () async{
                            if (formKey.currentState!.validate()) {
                              registerController.email = email.trim();
                              registerController.userName = userName.trim();
                              registerController.password = password.trim();
                              registerController.context = context;
                              await registerController.signUp();
                            }
                          },
                          child: const Text(
                            "Register",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const TextUtils(
                      text: "I have already account",
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0,
                    ),
                    TextButton(
                      onPressed: () {
                        Get.off(
                          () => LoginScreen(),
                          transition: Transition.upToDown,
                          duration: const Duration(milliseconds: 400),
                        );
                      },
                      child: const TextUtils(
                        text: "Click Here",
                        color: Color(0xFF1C3E66),
                        fontWeight: FontWeight.bold,
                        fontSize: 15.0,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
