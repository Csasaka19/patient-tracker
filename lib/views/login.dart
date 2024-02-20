import 'package:flutter/material.dart';
import 'package:patient_tracker/configs/constants.dart';
import 'package:patient_tracker/customs/custombutton.dart';
import 'package:patient_tracker/customs/customtext.dart';
import 'package:patient_tracker/customs/customtextfield.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController userNameController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
        backgroundColor: primaryColor,
        foregroundColor: appbartextColor,
        automaticallyImplyLeading: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(50, 30, 50, 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     Image.asset("assets/images/first.png"),
              //   ],
              // ),
              const SizedBox(height: 20),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  customtitleText(
                      label: "Login Screen",
                      labelColor: primaryColor,
                      labelfontSize: 30)
                ],
              ),
              const SizedBox(height: 10),
              const customtitleText(label: "Username"),
              customTextField(
                userFieldController: userNameController,
                icon: Icons.person,
                hint: "Enter your username",
              ),
              const customtitleText(label: "Password"),
              customTextField(
                  userFieldController: passwordController,
                  icon: Icons.lock,
                  hideText: true,
                  isPassword: true,
                  hint: "Password"),
              const SizedBox(height: 20),
              const customButton(
                labelButton: "Login",
                labelColor: appbartextColor,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  customtitleText(label: "No account yet?"),
                  SizedBox(width: 10),
                  customtitleText(label: "Register", labelColor: primaryColor),
                ],
              ),
              const SizedBox(height: 50),
              GestureDetector(
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    customtitleText(label: "Forgot password?"),
                    SizedBox(width: 10),
                    customtitleText(label: "Recover", labelColor: primaryColor),
                    //  OnTap: () {
                    //   print("Recovery process has began"); },
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
