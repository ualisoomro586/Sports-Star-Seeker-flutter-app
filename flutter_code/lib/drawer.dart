// ignore_for_file: prefer_const_constructors, camel_case_types

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'auth_service.dart';

class drawer extends StatelessWidget {
  const drawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Center(
          child: Column(
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              UserAccountsDrawerHeader(
                accountName:
                    Text("${FirebaseAuth.instance.currentUser!.displayName}"),
                accountEmail:
                    Text("${FirebaseAuth.instance.currentUser!.email}"),
                currentAccountPicture: CircleAvatar(
                  radius: 50.0,
                  backgroundColor: const Color(0xFF778899),
                  backgroundImage: AssetImage("assets/user.png"),
                ),
              ),
              ListTile(
                onTap: () {
                  Navigator.pop(context);
                },
                leading: Icon(
                  Icons.home,
                  size: 27,
                ),
                title: Text(
                  "Home",
                  style: TextStyle(fontSize: 16),
                ),
              ),
              // ListTile(
              //   leading: Icon(
              //     Icons.password,
              //     size: 27,
              //   ),
              //   title: Text(
              //     "Change Password",
              //     style: TextStyle(fontSize: 16),
              //   ),
              // ),
              ListTile(
                leading: Icon(
                  Icons.logout_sharp,
                  size: 27,
                ),
                title: Text(
                  "Sign out",
                  style: TextStyle(fontSize: 16),
                ),
                onTap: () {
                  AuthService().signOut(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
