import 'package:flutter/material.dart';
import 'package:patient_tracker/configs/constants.dart';

var defaultBackgroundColor = greyColor;
var appBarColor = blackColor;
var myAppBar = AppBar(
  backgroundColor: appBarColor,
  title: const Text(' '),
  centerTitle: false,
);
var drawerTextColor = const TextStyle(
  color: appbartextColor,
);
var tilePadding = const EdgeInsets.only(left: 8.0, right: 8, top: 8);
var myDrawer = Drawer(
  backgroundColor: const Color.fromARGB(255, 38, 37, 37),
  elevation: 0,
  child: Column(
    children: [
       const DrawerHeader(
        child: Icon(
          Icons.medical_services_rounded,
          size: 65,
        ),
      ),
      Padding(
        padding: tilePadding,
        child: ListTile(
          leading:  const Icon(Icons.home),
          title: Text(
            'D A S H B O A R D',
            style: drawerTextColor,
          ),
        ),
      ),
      Padding(
        padding: tilePadding,
        child: ListTile(
          leading: const Icon(Icons.settings),
          title: Text(
            'S E T T I N G S',
            style: drawerTextColor,
          ),
        ),
      ),
      Padding(
        padding: tilePadding,
        child: ListTile(
          leading: const Icon(Icons.info),
          title: Text(
            'A B O U T',
            style: drawerTextColor,
          ),
        ),
      ),
      Padding(
        padding: tilePadding,
        child: ListTile(
          leading: const Icon(Icons.account_box_rounded),
          title: Text(
            'A C C O U N T',
            style: drawerTextColor,
          ),
        ),
      ),
      Padding(
        padding: tilePadding,
        child: ListTile(
          leading: const Icon(Icons.logout),
          title: Text(
            'L O G O U T',
            style: drawerTextColor,
          ),
        ),
      ),
    ],
  ),
);
