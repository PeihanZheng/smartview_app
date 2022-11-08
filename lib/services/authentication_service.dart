// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smarview_app/constants/api_routes.dart';
import 'package:smarview_app/models/data_models/user_model.dart';
import 'package:smarview_app/models/http_exception.dart';
import 'package:smarview_app/models/http_response.dart';
import 'package:smarview_app/pages/dashboard_module/home_page.dart';

class AuthenticationService {
  UserModel userData = UserModel();
  Dio dio = Dio();
  // User? user;

  // Stream<User?> get authStateChanges => FirebaseAuth.instance.authStateChanges();

  showSnackbar(BuildContext ctx, String message) {
    ScaffoldMessenger.of(ctx).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.blue.shade800,
          ),
        ),
        behavior: SnackBarBehavior.floating,
        elevation: 0,
        duration: const Duration(seconds: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        margin: const EdgeInsets.all(8),
        backgroundColor: Colors.blue.shade800.withOpacity(.2),
      ),
    );
  }

  void setUserData(UserModel userData) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final encodedData = json.encode(userData);
    if (prefs.containsKey('userdata')) {
      prefs.remove('userdata');
    }
    prefs.setString('userdata', encodedData);
  }

  Future<HttpResponse?> signInMethod(BuildContext context, {String? username, String? password}) async {
    const url = ApiRouter.baseUrl + ApiRouter.signInUrl;
    try {
      Response response = await dio.post(
        url,
        data: {
          "username": username,
          "password": password,
        },
        options: Options(
          headers: {
            "Accept": "application/json",
            "Content-type": "application/json",
          },
        ),
      );
      if (response.statusCode == 200) {
        if (response.data['status'] == false) {
          throw HttpException(response.data['message']);
        } else {
          setUserData(UserModel.fromJson(response.data['user']));
          // ignore: use_build_context_synchronously
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const Homepage(),
            ),
          );
        }
      }
    } on DioError catch (error) {
      if (error.response?.statusCode == 400) {
        showSnackbar(context, 'Invalid Password');
      } else if (error.response?.statusCode == 401) {
        showSnackbar(context, 'This account has been disabled, please get in contact with the Administator.');
      } else if (error.response?.statusCode == 404) {
        showSnackbar(context, 'User is not in the records');
      } else if (error.response?.statusCode == 500) {
        showSnackbar(context, 'Error message generated by the server');
      }
    } catch (error) {
      Logger().e(error.toString());
      return HttpResponse(status: "false", message: "Somthing wrong please try anagin");
    }
  }

  // Future<User?> signUp(BuildContext context, {String? email, String? password}) async {
  //   try {
  //     UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email!, password: password!);
  //     user = userCredential.user;
  //     if (user != null) {
  //       // ignore: use_build_context_synchronously
  //       Navigator.pushReplacement(
  //         context,
  //         MaterialPageRoute(
  //           builder: (context) => const Dashboard(),
  //         ),
  //       );
  //     }
  //   } on FirebaseAuthException catch (e) {
  //     showSnackbar(context, e.message.toString());
  //   }
  //   return user;
  // }

  // Future<String> signOut() async {
  //   try {
  //     await FirebaseAuth.instance.signOut();
  //     return "Signed out";
  //   } on FirebaseAuthException catch (e) {
  //     return e.message.toString();
  //   }
  // }

  // User? getUser() {
  //   try {
  //     return FirebaseAuth.instance.currentUser;
  //   } on FirebaseAuthException {
  //     return null;
  //   }
  // }
}
