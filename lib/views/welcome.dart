import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:patient_tracker/configs/constants.dart';
import 'package:patient_tracker/customs/customtext.dart';

class WelcomeView extends StatefulWidget {
  const WelcomeView({super.key});

  @override
  _WelcomeViewState createState() => _WelcomeViewState();
}

class _WelcomeViewState extends State<WelcomeView>
    with TickerProviderStateMixin {
  late AnimationController animationController;
  late bool seenOnboarding;

  final GetStorage storage = GetStorage();

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    seenOnboarding = storage.read('seenOnboarding') ?? false;

    Future.delayed(const Duration(seconds: 3), () {
      if (seenOnboarding) {
        Get.offAll('/login');
      } else {
        storage.write('seenOnboarding', true);
        Get.offAll('/onboarding');
      }
    });
    animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/doctors/doctor_4.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.black.withOpacity(.8),
                    Colors.black.withOpacity(.7),
                    Colors.black.withOpacity(.2),
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
              child:
                  Column(mainAxisAlignment: MainAxisAlignment.end, children: [
                const CustomText(
                    label: "Patient Tracker",
                    fontSize: 40,
                    labelColor: appbartextColor,
                    italic: true),
                const SizedBox(height: 10),
                const CustomText(
                    label: "Find your medical records, appointments, and more",
                    fontSize: 17,
                    labelColor: appbartextColor,
                    italic: true),
                const SizedBox(height: 30),
                Container(
                  height: 50,
                  width: double.infinity,
                  margin:
                      const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                  decoration: BoxDecoration(
                    color: secondaryColor,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: const Center(
                    child: CustomText(
                        label: "Get Started",
                        fontSize: 20,
                        labelColor: primaryColor,
                        italic: true),
                  ),
                )
              ]),
            )));
  }
}
