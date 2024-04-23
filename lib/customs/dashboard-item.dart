import 'package:flutter/material.dart';
import 'package:patient_tracker/configs/constants.dart';
import 'package:patient_tracker/customs/customtext.dart';

class DashboardItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final String imagepath;
  final VoidCallback onTap;

  DashboardItem(
      {required this.title,
      required this.icon,
      required this.imagepath,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(11),
        image:  DecorationImage(
        image: AssetImage(imagepath),
        fit: BoxFit.cover,
        colorFilter: ColorFilter.mode(blackColor.withOpacity(0.7), BlendMode.dstATop),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        Icon(
          icon,
          size: 48,
          color: appbartextColor,
        ),
        const SizedBox(height: 10),
        CustomText(label: title, labelColor: appbartextColor, fontSize: 16, italic: true,),
        ],
      ),
      ),
    );
  }
}
