import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:larning/utils/animation_enum.dart';
import 'package:larning/auth/login_controller.dart';
import 'package:larning/auth/register_screen.dart';
import 'package:larning/utils/custom_textField.dart';
import 'package:larning/utils/reg_exp.dart';
import 'package:larning/utils/text_utils.dart';
import 'package:rive/rive.dart';

String? email;

String? password;

StateMachineController? controller;

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  final loginController = Get.put(LoginController());

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Scaffold(
        backgroundColor: const Color(0xFFD6E2EA),
        appBar: AppBar(
          backgroundColor: const Color(0xFF1C3E66),
          title: const Text("Login"),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                width: 300.0,
                height: 300.0,
                child: RiveAnimation.asset(
                  "assets/images/bear.riv",
                  fit: BoxFit.cover,
                  stateMachines: const ["Login Machine"],
                  onInit: (p0) {
                    controller = StateMachineController.fromArtboard(
                      p0,
                      "Login Machine",
                    );
                    if (controller == null) {
                      return;
                    } else {
                      p0.addController(controller!);
                      loginController.isChecking =
                          controller?.findInput(EnumStatus.isChecking.name);
                      loginController.numLook =
                          controller?.findInput(EnumStatus.numLook.name);
                      loginController.isHandsUp =
                          controller?.findInput(EnumStatus.isHandsUp.name);
                      loginController.trigSuccess =
                          controller?.findInput(EnumStatus.trigSuccess.name);
                      loginController.trigFail =
                          controller?.findInput(EnumStatus.trigFail.name);
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: [
                      CustomTextField(
                        focusNode: loginController.emailFocusNode,
                        size: MediaQuery.of(context).size,
                        function: (value) {
                          email = value;
                          loginController.numLook
                              ?.change(value.length.toDouble() * 4);
                        },
                        hintText: "Email",
                        prefix: Icons.email,
                        type: TextInputType.emailAddress,
                        validator: (value) {
                          if (!RegExp(validationEmail).hasMatch(value)) {
                            return "invalid email";
                          } else {
                            return null;
                          }
                        },
                      ),
                      CustomTextField(
                        obscureText: true,
                        focusNode: loginController.passwordFocusNode,
                        size: MediaQuery.of(context).size,
                        function: (value) {
                          password = value;
                        },
                        hintText: "Password",
                        prefix: Icons.key,
                        suffix: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.visibility,
                            color: Colors.grey,
                          ),
                        ),
                        type: TextInputType.emailAddress,
                        validator: (value) {
                          if (value.toString().length < 8) {
                            return "Password should be longer";
                          } else {
                            return null;
                          }
                        },
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 60,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF1C3E66),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          onPressed: () async {
                            loginController.context = context;
                            loginController.emailFocusNode.unfocus();
                            loginController.passwordFocusNode.unfocus();
                            if (formKey.currentState!.validate()) {
                              loginController.email = email;
                              loginController.password = password;
                              await loginController.signIn();
                            }
                            loginController.trigFail?.change(true);
                          },
                          child: const Text(
                            "Login",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const TextUtils(
                    text: "Create a new account",
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                    fontSize: 15.0,
                  ),
                  TextButton(
                    onPressed: () {
                      Get.off(
                        () => RegisterScreen(),
                        transition: Transition.downToUp,
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
    );
  }
}
