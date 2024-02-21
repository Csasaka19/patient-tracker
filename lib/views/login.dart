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
        title: const Text("Medical Login"),
        backgroundColor: primaryColor,
        foregroundColor: appbartextColor,
        automaticallyImplyLeading: true,
      ),
      body: Container(
        color: Colors.grey[200], // Background color
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(50, 10, 50, 7), // Updated padding values
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Transform.scale(
                    scale: 0.4, // Reduce size by 50%
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30), // Make image rounded
                      child: Image.asset("assets/images/medical-box.jpg"),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    customtitleText(
                        label: "Medical Login",
                        labelColor: primaryColor,
                        labelfontSize: 30)
                  ],
                ),
                const SizedBox(height: 10),
                const customtitleText(label: "Username", labelColor: primaryColor,),
                Center(
                  child: customTextField(
                    userFieldController: userNameController,
                    icon: Icons.person,
                    hint: "Enter your username",
                  ),
                ),
                const customtitleText(label: "Password", labelColor: primaryColor,),
                Center(
                  child: customTextField(
                    userFieldController: passwordController,
                    icon: Icons.lock,
                    hideText: true,
                    isPassword: true,
                    hint: "Password",
                  ),
                ),
                const SizedBox(height: 20),
                const customButton(
                  labelButton: "Login",
                  labelColor: appbartextColor,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    customtitleText(label: "No account yet?", labelColor: blackColor,),
                    SizedBox(width: 10),
                    customtitleText(label: "Register", labelColor: primaryColor),
                  ],
                ),
                const SizedBox(height: 50),
                GestureDetector(
                  onTap: () {
                    print("Recovery process has begun");
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      customtitleText(label: "Forgot password?", labelColor: blackColor,),
                      SizedBox(width: 10),
                      customtitleText(label: "Recover", labelColor: primaryColor),
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
}
