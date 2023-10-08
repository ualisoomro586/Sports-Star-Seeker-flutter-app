// ignore_for_file: prefer_const_constructors, sort_child_properties_last, unused_import, prefer_const_literals_to_create_immutables, camel_case_types

import 'dart:math';

import 'package:flutter/material.dart';
import 'sign_in.dart';
import 'sign_up.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class welcome extends StatefulWidget {
  const welcome({super.key});

  @override
  State<welcome> createState() => _welcomeState();
}

class _welcomeState extends State<welcome> {
  bool storagePermissionGranted = true;

  @override
  void initState() {
    super.initState();
    checkAndRequestStoragePermission();
  }

  Future<void> checkAndRequestStoragePermission() async {
    // final SharedPreferences prefs = await SharedPreferences.getInstance();

    // // Check if the storage permission has been requested before
    // bool storagePermissionRequested =
    //     prefs.getBool('storage_permission_requested') ?? false;

    // if (!storagePermissionRequested) {
    //   var status = await Permission.storage.request();
    //   prefs.setBool('storage_permission_requested', true);

    //   if (status.isGranted) {
    //     setState(() {
    //       storagePermissionGranted = true;
    //     });
    //   } else {
    //     ScaffoldMessenger.of(context).showSnackBar(
    //       SnackBar(
    //         content: Text('Storage permission is required to use this app.'),
    //       ),
    //     );
    //   }
    // } else {
    //   // Check the current status of storage permission
    //   var status = await Permission.storage.status;
    //   if (status.isGranted) {
    //     setState(() {
    //       storagePermissionGranted = true;
    //     });
    //   }
    // }

    var status = await Permission.storage.request();

    if (status.isGranted) {
      setState(() {
        storagePermissionGranted = true;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Storage permission is required to use this app.'),
          action: SnackBarAction(
              label: 'Open settings',
              onPressed: () {
                openAppSettings();
              }),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    var orientation = MediaQuery.of(context).orientation;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("Welcome To Sports Star Seeker"),
          backgroundColor: Colors.lightBlue,
        ),
        body: orientation == Orientation.portrait
            ? Container(
                height: height * 10,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                  Color.fromARGB(245, 246, 250, 255),
                  Color.fromARGB(226, 228, 246, 255)
                ])),
                child: Padding(
                  padding: EdgeInsets.all(30),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset('assets/welcome2.png'),
                        SizedBox(
                          height: 50,
                        ),
                        Text(
                          "Welcome!",
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.right,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Login with your data that you have entered during Your registration",
                          style: TextStyle(
                            fontSize: 20,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        SizedBox(
                          height: 60,
                        ),
                        ElevatedButton(
                            onPressed: storagePermissionGranted
                                ? () {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const sign_up()));
                                  }
                                : null,
                            child:
                                Text("Sign Up", style: TextStyle(fontSize: 20)),
                            style: storagePermissionGranted
                                ? ElevatedButton.styleFrom(
                                    fixedSize: Size(width * 0.85, 50),
                                    shape: StadiumBorder(),
                                    backgroundColor: Colors.blue[600])
                                : ElevatedButton.styleFrom(
                                    fixedSize: Size(width * 0.85, 50),
                                    shape: StadiumBorder(),
                                    backgroundColor: Colors.grey)),
                        SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                            onPressed: storagePermissionGranted
                                ? () {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const sign_in()));
                                  }
                                : null,
                            child: Text(
                              "Sign in",
                              style: TextStyle(fontSize: 20),
                            ),
                            style: storagePermissionGranted
                                ? ElevatedButton.styleFrom(
                                    fixedSize: Size(width * 0.85, 50),
                                    shape: StadiumBorder(),
                                    backgroundColor: Colors.amber[400],
                                  )
                                : ElevatedButton.styleFrom(
                                    fixedSize: Size(width * 0.85, 50),
                                    shape: StadiumBorder(),
                                    backgroundColor: Colors.grey,
                                  ))
                      ]),
                ),
              )
            : Container(
                height: height * 10,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                  Color.fromARGB(245, 246, 250, 255),
                  Color.fromARGB(226, 228, 246, 255)
                ])),
                child: Padding(
                  padding: EdgeInsets.all(30),
                  child: SingleChildScrollView(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset('assets/welcome2.png'),
                          SizedBox(
                            height: 50,
                          ),
                          Text(
                            "Welcome!",
                            style: TextStyle(
                                fontSize: 40, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.right,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Login with your data that you have entered during Your registration",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.left,
                          ),
                          SizedBox(
                            height: 60,
                          ),
                          ElevatedButton(
                              onPressed: storagePermissionGranted
                                  ? () {
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const sign_up()));
                                    }
                                  : null,
                              child: Text("Sign Up",
                                  style: TextStyle(fontSize: 20)),
                              style: storagePermissionGranted
                                  ? ElevatedButton.styleFrom(
                                      fixedSize: Size(width * 0.7, 50),
                                      shape: StadiumBorder(),
                                      backgroundColor: Colors.blue[600])
                                  : ElevatedButton.styleFrom(
                                      fixedSize: Size(width * 0.7, 50),
                                      shape: StadiumBorder(),
                                      backgroundColor: Colors.grey)),
                          SizedBox(
                            height: 20,
                          ),
                          ElevatedButton(
                              onPressed: storagePermissionGranted
                                  ? () {
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const sign_in()));
                                    }
                                  : null,
                              child: Text(
                                "Sign in",
                                style: TextStyle(fontSize: 20),
                              ),
                              style: storagePermissionGranted
                                  ? ElevatedButton.styleFrom(
                                      fixedSize: Size(width * 0.7, 50),
                                      shape: StadiumBorder(),
                                      backgroundColor: Colors.amber[400],
                                    )
                                  : ElevatedButton.styleFrom(
                                      fixedSize: Size(width * 0.7, 50),
                                      shape: StadiumBorder(),
                                      backgroundColor: Colors.grey,
                                    ))
                        ]),
                  ),
                ),
              ));
  }
}
