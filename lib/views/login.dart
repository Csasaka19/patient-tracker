import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:patient_tracker/configs/constants.dart';
import 'package:patient_tracker/customs/custombutton.dart';
import 'package:patient_tracker/customs/customtext.dart';
import 'package:patient_tracker/customs/customtextfield.dart';
import 'package:patient_tracker/customs/square_tile.dart';
import 'package:patient_tracker/utils/prefs.dart';

TextEditingController userNameController = TextEditingController();
TextEditingController passwordController = TextEditingController();

Prefs myprefs = Prefs();

class Login extends StatelessWidget {
  const Login({super.key});

  void loginButtonPressed() {}

  @override
  Widget build(BuildContext context) {
    myprefs.getValue("username").then((value) {
      userNameController.text = value;
    });

    return Scaffold(
      backgroundColor: greyColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
          
                // logo
                const Image(
                  image: AssetImage('assets/logos/examination.png'),
                  width: 100,
                  height: 100,
                ),
                
                const SizedBox(height: 30),
          
                // welcome back!
                const CustomText(label: "Welcome back you!", fontSize: 30),
          
                const SizedBox(height: 25),
          
                // username textfield
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CustomText(
                        label: "Username", labelColor: blackColor, fontSize: 16),
                    const SizedBox(width: 10),
                    customTextField(
                      userFieldController: userNameController,
                      icon: Icons.person,
                      hint: 'Username',
                    ),
                  ],
                ),
          
                const SizedBox(height: 10),
          
                // password textfield
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CustomText(
                        label: "Password", labelColor: blackColor, fontSize: 16),
                    const SizedBox(width: 10),
                    customTextField(
                      userFieldController: passwordController,
                      icon: Icons.lock,
                      isPassword: true,
                      hint: 'Password',
                      hideText: true,
                    ),
                  ],
                ),
          
                const SizedBox(height: 30),
          
                // Forgot password section
                GestureDetector(
                  onTap: () {
                    print("Recovery process has begun");
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomText(
                        label: "Forgot password?",
                        labelColor: blackColor,
                      ),
                      SizedBox(width: 5),
                      CustomText(label: "Recover", labelColor: primaryColor),
                    ],
                  ),
                ),
          
                const SizedBox(height: 40),
          
                // Log in button
                customButton(
                  labelButton: 'Login',
                  labelColor: appbartextColor,
                  action: () => remoteLogin(),
                ),
          
                const SizedBox(height: 20),
          
                // Alternative login options
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 0.6,
                          color: blackColor,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        child: CustomText(
                            label: "Or Continue with",
                            labelColor: blackColor,
                            fontSize: 16),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: blackColor,
                        ),
                      ),
                    ],
                  ),
                ),
          
                const SizedBox(height: 50),
          
                //  Google + Fit sign in buttons
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Google button
                    SquareTile(imagePath: 'assets/images/google.png'),
          
                    SizedBox(width: 25),
                  ],
                ),
          
                const SizedBox(height: 50),
          
                // Non member section
                GestureDetector(
                  onTap: () => gotoRegistration(),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomText(
                          label: "Not a member?",
                          labelColor: blackColor,
                          fontSize: 16),
                      SizedBox(width: 4),
                      CustomText(
                          label: "Register",
                          labelColor: primaryColor,
                          fontSize: 16),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> remoteLogin() async {
    http.Response response;
    response = await http.get(Uri.parse(
        'http://acs314flutter.xyz/Patient-tracker/login.php?username=${userNameController.text.trim()}&password=${passwordController.text.trim()}'));
    if (response.statusCode == 200) {
      var serverResponse = json.decode(response.body);
      int serverStatus = serverResponse['success'];
      if (serverStatus == 1) {
        print('Login successful');
        gotoHome();
      } else {
        print('Login failed');
      }
    } else {
      print('Username or password is incorrect');
    }
  }

  void gotoHome() {
    myprefs.setValue("username", userNameController.text);
    Get.toNamed('/home');
  }

  void gotoRegistration() {
    Get.toNamed('/registration');
  }
}
