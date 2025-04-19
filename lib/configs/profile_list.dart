import 'package:flutter/material.dart';
import 'package:patient_tracker/configs/constants.dart';
import 'package:patient_tracker/customs/customtext.dart';


class profile_list extends StatelessWidget {
  final String title;
  final String image;
  final Color color;

  const profile_list({super.key, required this.image, required this.title, required this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.06,
            width: MediaQuery.of(context).size.width * 0.9,
            child: Row(children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.06,
                width: MediaQuery.of(context).size.width * 0.1500,
                decoration: const BoxDecoration(
                  color: Color(0xFFF7FAF7),
                  shape: BoxShape.circle,
                ),
                child: Image.asset(image),
              ),
              const SizedBox(
                width: 5,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.06,
                width: MediaQuery.of(context).size.width * 0.5800,
                child: Row(children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: CustomText(
                      label: title,
                      fontSize: 14,
                      labelColor: appbartextColor,
                    ),
                  ),
                ]),
              ),
              Container(
                  height: MediaQuery.of(context).size.height * 0.06,
                  width: MediaQuery.of(context).size.width * 0.1100,
                  decoration: const BoxDecoration(),
                  child: Image.asset("assets/icons/forward.png")),
            ]),
          ),
        ],
      ),
    );
  }
}
