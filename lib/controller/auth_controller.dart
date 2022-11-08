import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smarview_app/models/data_models/user_model.dart';
import 'package:smarview_app/pages/dashboard_module/home_page.dart';

class AuthController extends GetxController {
  UserModel userData = UserModel();
  Dio dio = Dio();
  User? user;

  Future<User?> signIn(BuildContext context, String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      user = userCredential.user;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      if (user != null) {
        DocumentSnapshot<Map<String, dynamic>> userData = await FirebaseFirestore.instance.collection("usersData").doc(user!.uid).get();
        UserModel userInfo = UserModel(
          id: user!.uid,
          username: userData['username'],
          emailAddress: userData["email_address"],
        );
        final encodedData = json.encode(userInfo.toJson());
        prefs.setString("userdata", encodedData);
        // ignore: use_build_context_synchronously
        customSnackbar(context, msg: "User Logged in", isSuccessMsg: true);
        Get.off(const Homepage());
      }
    } on FirebaseAuthException catch (e) {
      customSnackbar(context, msg: e.message, isSuccessMsg: false);
    }
    return user;
  }

  customSnackbar(BuildContext context, {String? msg, bool? isSuccessMsg}) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.white,
        elevation: 5,
        behavior: SnackBarBehavior.floating,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
            side: BorderSide(
              width: 1,
              color: Colors.blue[800]!.withOpacity(.3),
            )),
        duration: const Duration(seconds: 5),
        content: Text(
          msg!,
          style: TextStyle(
            fontSize: 15,
            color: isSuccessMsg! ? Colors.green : Colors.red,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
