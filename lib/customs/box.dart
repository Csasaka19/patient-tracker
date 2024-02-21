import 'package:flutter/material.dart';

class MyBox extends StatelessWidget {
  // Create a custom box widget
  final String title;
  final String subtitle;
  final IconData icon;
  const MyBox({Key? key, required this.title, required this.subtitle, required this.icon}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.grey[400],
        ),
        child: Column(
          children: [
            Text(title),
            Text(subtitle),
            Icon(icon),
          ],
        ),
      ),
    );
  }
}
