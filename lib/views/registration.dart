import 'package:flutter/material.dart';
import 'package:patient_tracker/configs/constants.dart';
import 'package:patient_tracker/customs/custombutton.dart';
import 'package:patient_tracker/customs/customtext.dart';
import 'package:patient_tracker/customs/customtextfield.dart';


void main() {
  runApp( MaterialApp(
    home: Registration(),
    debugShowCheckedModeBanner: false,
  ));
}

class Registration extends StatelessWidget {
  Registration({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController userNameController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 76, 72, 72),
      appBar: AppBar(
        title: const Text("Register"),
        backgroundColor: primaryColor,
        foregroundColor: appbartextColor,
        automaticallyImplyLeading: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(50, 30, 50, 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 100,
                width: 100,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(60),
                  child: Image.asset(
                    "assets/images/medical-box.jpg",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  customtitleText(
                      label: "Registration Screen",
                      labelColor: primaryColor,
                      labelfontSize: 30)
                ],
              ),
              const SizedBox(height: 10),
              const customtitleText(label: "First name"),
              const SizedBox(height: 5),
              customTextField(
                userFieldController: userNameController,
                icon: Icons.person,
                hint: "Enter your first name",
              ),
              const SizedBox(height: 10),
              const customtitleText(label: "Second name"),
              const SizedBox(height: 5),
              customTextField(
                userFieldController: userNameController,
                icon: Icons.person,
                hint: "Enter your second name",
              ),
              const SizedBox(height: 10),
              const customtitleText(label: "Phone number"),
              const SizedBox(height: 5),
              customTextField(
                userFieldController: userNameController,
                icon: Icons.phone,
                hint: "Input your phone number",
              ),
              const SizedBox(height: 10),
              const customtitleText(label: "Email"),
              const SizedBox(height: 5),
              customTextField(
                userFieldController: userNameController,
                icon: Icons.email,
                hint: "Input your email",
              ),
              const SizedBox(height: 10),
              const customtitleText(label: "Password"),
              const SizedBox(height: 5),
              customTextField(
                  userFieldController: passwordController,
                  icon: Icons.lock,
                  hideText: true,
                  isPassword: true,
                  hint: "Password"),
              const SizedBox(height: 10),
              const customtitleText(label: "Confirm Password"),
              const SizedBox(height: 5),
              customTextField(
                  userFieldController: passwordController,
                  icon: Icons.lock,
                  hideText: true,
                  isPassword: true,
                  hint: "Re-enter Password"),
              const SizedBox(height: 20),
              const customButton(
                labelColor: primaryColor,
                labelButton: "Register",
              ),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}
