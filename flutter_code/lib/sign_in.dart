// ignore_for_file: camel_case_types, prefer_const_constructors, sort_child_properties_last, prefer_const_literals_to_create_immutables, use_build_context_synchronously, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'sign_up.dart';
import 'auth_service.dart';

class sign_in extends StatefulWidget {
  const sign_in({super.key});

  @override
  State<sign_in> createState() => _sign_inState();
}

class _sign_inState extends State<sign_in> {
  bool isLoading = false;
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();

  @override
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    var orientation = MediaQuery.of(context).orientation;
    Future<void> SignIn() async {
      // Simulating the data sending process
      setState(() {
        isLoading = true;
      });
      await Future.delayed(Duration(seconds: 1));
      AuthService()
          .signIn(emailcontroller.text, passwordcontroller.text, context);

      // Simulating the data receiving process
      setState(() {
        isLoading = false;
      });
    }

    return Scaffold(
        body: orientation == Orientation.portrait
            ? Container(
                height: height * 10,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Color(0xFF8EC5FC), Color(0xFFE0C3FC)])),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        alignment: Alignment.centerLeft,
                        children: [
                          Container(
                            height: height * 0.30,
                            width: width * 10,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(70)),
                              color: Colors.white60,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(25, 0, 0, 0),
                            child: Text(
                              "Welcome!",
                              style: TextStyle(
                                fontSize: 30,
                                color: Colors.lightBlue,
                              ),
                            ),
                          ),
                          Padding(
                              padding: EdgeInsets.fromLTRB(25, 80, 0, 0),
                              child: Text(
                                "Sign in and get started",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                ),
                              )),
                        ],
                      ),
                      SizedBox(
                        height: 60,
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(65, 0, 0, 10),
                        child: Text("Email",
                            style:
                                TextStyle(color: Colors.black, fontSize: 18)),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(40, 0, 30, 20),
                        child: TextFormField(
                          controller: emailcontroller,
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.email),
                              hintText: "Enter email",
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 20.0, horizontal: 10.0),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50))),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(65, 15, 0, 10),
                        child: Text(
                          "Password",
                          style: TextStyle(color: Colors.black, fontSize: 18),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(40, 0, 30, 20),
                        child: TextFormField(
                          controller: passwordcontroller,
                          obscureText: true,
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.password),
                              hintText: "Enter password",
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 20.0, horizontal: 10.0),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50))),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(40, 40, 30, 20),
                        child: ElevatedButton(
                          onPressed: isLoading ? null : () => SignIn(),
                          child: isLoading
                              ? CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white),
                                )
                              : Text("Sign in", style: TextStyle(fontSize: 20)),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue[500],
                            fixedSize: Size(width * 0.85, 50),
                            shape: StadiumBorder(),
                          ),
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.fromLTRB(80, 0, 30, 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Don't have account?",
                                style: TextStyle(
                                    decoration: TextDecoration.underline),
                              ),
                              TextButton(
                                  onPressed: () {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => sign_up()));
                                  },
                                  child: Text("Sign up"))
                            ],
                          )),
                    ],
                  ),
                ))
            : Container(
                height: height * 10,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Color(0xFF8EC5FC), Color(0xFFE0C3FC)])),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            height: height * 0.40,
                            width: width * 10,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(80)),
                              color: Colors.white60,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(25, 0, 0, 0),
                            child: Text(
                              "Welcome Back",
                              style: TextStyle(
                                fontSize: 40,
                                color: Colors.lightBlue,
                              ),
                            ),
                          ),
                          Padding(
                              padding: EdgeInsets.fromLTRB(25, 80, 0, 0),
                              child: Text(
                                "Sign in and get started",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                ),
                              )),
                        ],
                      ),
                      SizedBox(
                        height: 60,
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(65, 0, 0, 10),
                        child: Text("Email",
                            style:
                                TextStyle(color: Colors.black, fontSize: 18)),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(40, 0, 30, 20),
                        child: TextFormField(
                          controller: emailcontroller,
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.email),
                              hintText: "Enter email",
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 20.0, horizontal: 10.0),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50))),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(65, 15, 0, 10),
                        child: Text(
                          "Password",
                          style: TextStyle(color: Colors.black, fontSize: 18),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(40, 0, 30, 20),
                        child: TextFormField(
                          controller: passwordcontroller,
                          obscureText: true,
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.password),
                              hintText: "Enter password",
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 20.0, horizontal: 10.0),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50))),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(110, 40, 30, 20),
                        child: ElevatedButton(
                          onPressed: isLoading ? null : () => SignIn(),
                          child: isLoading
                              ? CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white),
                                )
                              : Text("Sign in", style: TextStyle(fontSize: 20)),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue[500],
                            fixedSize: Size(width * 0.7, 50),
                            shape: StadiumBorder(),
                          ),
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.fromLTRB(290, 0, 30, 20),
                          child: Row(
                            children: [
                              Text(
                                "Don't have account?",
                                style: TextStyle(
                                    decoration: TextDecoration.underline),
                              ),
                              TextButton(
                                  onPressed: () {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => sign_up()));
                                  },
                                  child: Text("Sign up"))
                            ],
                          )),
                    ],
                  ),
                )));
  }
}
