// ignore_for_file: use_build_context_synchronously, avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'main_screen.dart';
import 'sign_in.dart';

class AuthService {
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> signUp(
      String name, String email, String password, BuildContext context) async {
    try {
      UserCredential uc = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      if (uc.user != null) {
        auth.currentUser!.updateDisplayName(name);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Registration successful"),
        ));
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const Screen()));
      }
      // Navigator.push(
      //     context, MaterialPageRoute(builder: (context) => Screen()));
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    } catch (e) {
      print(e);
    }
  }

  Future<void> signIn(
      String email, String password, BuildContext context) async {
    try {
      UserCredential uc = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      if (uc.user != null) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const Screen()));
      }
      // Navigator.push(
      //     context, MaterialPageRoute(builder: (context) => Screen()));
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    } catch (e) {
      print(e);
    }
  }

  signOut(BuildContext context) async {
    await auth.signOut().whenComplete(() => Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const sign_in())));
  }
}
