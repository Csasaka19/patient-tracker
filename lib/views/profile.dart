import 'package:flutter/material.dart';
import 'package:patient_tracker/configs/constants.dart';
import 'package:patient_tracker/configs/profile_list.dart';
import 'package:patient_tracker/customs/customtext.dart';



class Profile_screen extends StatelessWidget {
  const Profile_screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightBlue,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            Center(
              child: Stack(
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  Container(
                    width: 110,
                    height: 110,
                    decoration: BoxDecoration(
                        border: Border.all(width: 4, color: appbartextColor),
                        boxShadow: [
                          BoxShadow(
                              spreadRadius: 2,
                              blurRadius: 10,
                              color: blackColor.withOpacity(0.1))
                        ],
                        shape: BoxShape.circle,
                        image: const DecorationImage(
                          image: AssetImage("assets/logos/man.png"),
                          fit: BoxFit.cover,
                        )),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(width: 1, color: appbartextColor),
                          color: appbartextColor,
                          image: const DecorationImage(
                              image: AssetImage("assets/icons/camera.png"))),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomText(label: "Clive Sasaka", fontSize: 20, labelColor: appbartextColor),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.0900,
                    width: MediaQuery.of(context).size.width * 0.2500,
                    child: Column(children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.0400,
                        width: MediaQuery.of(context).size.width * 0.1500,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("assets/icons/calories.png"),
                              filterQuality: FilterQuality.high),
                        ),
                      ),
                      const CustomText(label: "Calories", fontSize: 12, labelColor: appbartextColor),
                      const SizedBox(
                        height: 5,
                      ),
                      const CustomText(label: "215cal", fontSize: 14, labelColor: appbartextColor),
                    ]),
                  ),
                  Container(
                    height: 50,
                    width: 1,
                    color: appbartextColor,
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.0900,
                    width: MediaQuery.of(context).size.width * 0.2500,
                    child: Column(children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.0400,
                        width: MediaQuery.of(context).size.width * 0.1500,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("assets/icons/weight.png"),
                              filterQuality: FilterQuality.high),
                        ),
                      ),
                      const CustomText(label: "Weight", fontSize: 12, labelColor: appbartextColor),
                      const SizedBox(
                        height: 5,
                      ),
                      const CustomText(label: "215kg", fontSize: 14, labelColor: appbartextColor),
                    ]),
                  ),
                  Container(
                    height: 50,
                    width: 1,
                    color: appbartextColor,
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.0900,
                    width: MediaQuery.of(context).size.width * 0.2500,
                    child: Column(children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.0400,
                        width: MediaQuery.of(context).size.width * 0.1500,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("assets/icons/heart.png"),
                              filterQuality: FilterQuality.high),
                        ),
                      ),
                      const CustomText(label: "Heart Rate", fontSize: 12, labelColor: appbartextColor),
                      const SizedBox(
                        height: 5,
                      ),
                      const CustomText(label: "72bpm", fontSize: 14, labelColor: appbartextColor),
                    ]),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Container(
              height: 550,
              width: double.infinity,
              decoration: const BoxDecoration(
                  color: appbartextColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30))),
              child: Column(children: [
                const SizedBox(
                  height: 50,
                ),
                profile_list(
                  image: "assets/icons/heart2.png",
                  title: "Full Personal Details",
                  color: blackColor,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                  child: Divider(),
                ),
                profile_list(
                  image: "assets/icons/appoint.png",
                  title: "Doctors and Appointments",
                  color: blackColor,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                  child: Divider(),
                ),
                profile_list(
                  image: "assets/icons/hospital-insurance.png",
                  title: "Medications",
                  color: blackColor,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                  child: Divider(),
                ),
                profile_list(
                  image: "assets/icons/hospital.png",
                  title: "Hospitals",
                  color: blackColor,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                  child: Divider(),
                ),
                profile_list(
                  image: "assets/icons/logout.png",
                  title: "Log out",
                  color: pinkColor,
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
