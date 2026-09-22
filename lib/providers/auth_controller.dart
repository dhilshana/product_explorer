import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthController extends ChangeNotifier{

  Future<void> signUp(String email, String password) async {
    try {
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      print('User created: ${credential.user?.uid}');
    } on FirebaseAuthException catch (e) {
      print('Error: ${e.message}');
    }
  }

  Future<void> login(String email, String password) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      print('Login successful');
      print(credential.user?.email);
    } on FirebaseAuthException catch (e) {
      print('Login failed: ${e.message}');
    }
  }

}