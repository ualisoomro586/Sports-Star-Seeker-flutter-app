// ignore_for_file: unused_import, camel_case_types, prefer_const_constructors, sort_child_properties_last, prefer_const_literals_to_create_immutables, use_build_context_synchronously, non_constant_identifier_names, no_leading_underscores_for_local_identifiers
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'sign_in.dart';
import 'auth_service.dart';

class sign_up extends StatefulWidget {
  const sign_up({super.key});

  @override
  State<sign_up> createState() => _sign_upState();
}

class _sign_upState extends State<sign_up> {
  bool isLoading = false;
  TextEditingController email_c = TextEditingController();
  TextEditingController password_c = TextEditingController();
  TextEditingController name_c = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Future<void> _SignUp() async {
      // Simulating the data sending process
      setState(() {
        isLoading = true;
      });
      await Future.delayed(Duration(seconds: 1));
      AuthService().signUp(name_c.text, email_c.text, password_c.text, context);

      // Simulating the data receiving process
      setState(() {
        isLoading = false;
      });
    }

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    var orientation = MediaQuery.of(context).orientation;
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
                            height: height * 0.3,
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
                              "Create Account",
                              style: TextStyle(
                                fontSize: 30,
                                color: Colors.lightBlue,
                              ),
                            ),
                          ),
                          Padding(
                              padding: EdgeInsets.fromLTRB(25, 80, 0, 0),
                              child: Text(
                                "Sign up and get started",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                ),
                              )),
                        ],
                      ),
                      SizedBox(
                        height: 50,
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
                          controller: email_c,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.email),
                            hintText: "Enter email",
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 15.0, horizontal: 10.0),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50)),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(62, 0, 20, 15),
                        child: Row(
                          children: [
                            Text("First Name",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 15)),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(40, 0, 5, 20),
                        child: Row(
                          children: [
                            Flexible(
                              child: TextFormField(
                                controller: name_c,
                                decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.person),
                                    hintText: "Full name",
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 15.0, horizontal: 10.0),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(50))),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Enter Full name";
                                  }
                                  return null;
                                },
                              ),
                            ),
                            SizedBox(
                              width: 30,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(65, 0, 0, 10),
                        child: Text(
                          "Password",
                          style: TextStyle(color: Colors.black, fontSize: 18),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(40, 0, 30, 15),
                        child: TextFormField(
                          controller: password_c,
                          obscureText: true,
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.password),
                              hintText: "Set password",
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 15.0, horizontal: 10.0),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50))),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(40, 10, 30, 20),
                        child: ElevatedButton(
                          onPressed: isLoading ? null : () => _SignUp(),
                          child: isLoading
                              ? CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white),
                                )
                              : Text("Sign up", style: TextStyle(fontSize: 20)),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue[500],
                            fixedSize: Size(400, 50),
                            shape: StadiumBorder(),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(100, 0, 0, 0),
                        child: Row(children: [
                          Text("Already have an account?"),
                          TextButton(
                              onPressed: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => sign_in(),
                                    ));
                              },
                              child: Text("Sign in"))
                        ]),
                      ),
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
                            height: height * 0.4,
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
                              "Create Account",
                              style: TextStyle(
                                fontSize: 40,
                                color: Colors.lightBlue,
                              ),
                            ),
                          ),
                          Padding(
                              padding: EdgeInsets.fromLTRB(25, 80, 0, 0),
                              child: Text(
                                "Sign up and get started",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                ),
                              )),
                        ],
                      ),
                      SizedBox(
                        height: 50,
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
                          controller: email_c,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.email),
                            hintText: "Enter email",
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 15.0, horizontal: 10.0),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50)),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(62, 0, 20, 15),
                        child: Row(
                          children: [
                            Text("Full Name",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 15)),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(40, 0, 5, 20),
                        child: Row(
                          children: [
                            Flexible(
                              child: TextFormField(
                                controller: name_c,
                                decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.person),
                                    hintText: "Full name",
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 15.0, horizontal: 10.0),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(50))),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Enter Full name";
                                  }
                                  return null;
                                },
                              ),
                            ),
                            SizedBox(
                              width: 30,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(65, 0, 0, 10),
                        child: Text(
                          "Password",
                          style: TextStyle(color: Colors.black, fontSize: 18),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(40, 0, 30, 15),
                        child: TextFormField(
                          controller: password_c,
                          obscureText: true,
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.password),
                              hintText: "Set password",
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 15.0, horizontal: 10.0),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50))),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(110, 10, 30, 20),
                        child: ElevatedButton(
                          onPressed: isLoading ? null : () => _SignUp(),
                          child: isLoading
                              ? CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white),
                                )
                              : Text("Sign up", style: TextStyle(fontSize: 20)),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue[500],
                            fixedSize: Size(width * 0.7, 50),
                            shape: StadiumBorder(),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Already have an account?"),
                              TextButton(
                                  onPressed: () {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => sign_in(),
                                        ));
                                  },
                                  child: Text("Sign in"))
                            ]),
                      ),
                    ],
                  ),
                )));
  }
}
