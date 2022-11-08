import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smarview_app/constants/themes/colors.dart';
import 'package:smarview_app/constants/themes/textstyles.dart';

import '../../constants/assets.dart';

class Loginpage extends StatefulWidget {
  const Loginpage({Key? key}) : super(key: key);

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  final idController = TextEditingController();
  final passwordController = TextEditingController();

  var isLoading = false;

  bool _obsecureText = true;

  @override
  void dispose() {
    idController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _toggle() {
    setState(() {
      _obsecureText = !_obsecureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primarycolor,
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 32),
            alignment: Alignment.center,
            width: Get.width,
            height: Get.height * .3,
            color: primarycolor,
            child: Image.asset(
              appIcon,
              width: Get.width / 3.5,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: Get.width,
              height: Get.height * .7,
              decoration: const BoxDecoration(
                color: whitecolor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(80),
                ),
              ),
              padding: const EdgeInsets.only(top: 60, left: 30, right: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Login',
                    style: textstyle.copyWith(
                      fontSize: 35,
                      color: primarycolor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: Get.height * .03),
                  usernameWidget(),
                  const SizedBox(height: 30),
                  passwordWidget(),
                  const SizedBox(height: 30),
                  loginButton(),
                  const Expanded(child: SizedBox()),
                  dontHaveAccountwidget(),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget dontHaveAccountwidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Don\'t have an account yet?',
          style: textstyle.copyWith(
            fontSize: 14,
            color: textcolor,
            fontWeight: FontWeight.w700,
          ),
        ),
        TextButton(
          onPressed: () {
            Get.offNamed('/signup');
          },
          child: Text(
            'Sign Up',
            style: textstyle.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }

  Widget loginButton() {
    return ElevatedButton(
      onPressed: () async {
        setState(() {
          isLoading = true;
        });

        Future.delayed(const Duration(seconds: 2), () {
          Get.offNamed('/home-page');
        });
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(primarycolor),
        fixedSize: MaterialStateProperty.all(Size(Get.width, 50)),
        shape: MaterialStateProperty.all(const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          bottomLeft: Radius.circular(15),
          bottomRight: Radius.circular(15),
        ))),
      ),
      child: isLoading
          ? const SizedBox(
              height: 30,
              width: 30,
              child: CircularProgressIndicator(
                color: whitecolor,
                strokeWidth: 2,
              ),
            )
          : Text(
              'Login',
              style: textstyle.copyWith(
                fontSize: 18,
                color: whitecolor,
                fontWeight: FontWeight.w500,
              ),
            ),
    );
  }

  Widget passwordWidget() {
    return Container(
      padding: const EdgeInsets.only(top: 15),
      decoration: BoxDecoration(
        color: whitecolor,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            blurRadius: 8,
            spreadRadius: 1,
            offset: const Offset(0, 3),
            color: greycolor.withOpacity(.2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Text(
              'Password',
              style: textstyle.copyWith(
                fontSize: 16,
                color: textcolor,
                fontWeight: FontWeight.w700,
                letterSpacing: 1,
              ),
            ),
          ),
          TextFormField(
            obscureText: _obsecureText,
            controller: passwordController,
            validator: (password) {
              if (password == null) {
                return null;
              }
              if (password.isEmpty) {
                return showSnackbar('Password can\'t be empty');
              }
              // else if (password.length < 6) {
              //   return 'Enter a password with length at least 6';
              // }

              return null;
            },
            keyboardType: TextInputType.name,
            style: TextStyle(
              color: Colors.blue[800],
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.only(left: 15, top: 15, bottom: 15),
              border: InputBorder.none,
              disabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              hintText: 'Enter your Password',
              hintStyle: textstyle.copyWith(
                color: greycolor,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
              suffixIcon: GestureDetector(
                onTap: _toggle,
                child: Icon(
                  _obsecureText ? Icons.visibility_off : Icons.visibility,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget usernameWidget() {
    return Container(
      padding: const EdgeInsets.only(top: 15),
      decoration: BoxDecoration(
        color: whitecolor,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            blurRadius: 8,
            spreadRadius: 1,
            offset: const Offset(0, 3),
            color: greycolor.withOpacity(.2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Text(
              'Username',
              style: textstyle.copyWith(
                fontSize: 16,
                color: textcolor,
                fontWeight: FontWeight.w700,
                letterSpacing: 1,
              ),
            ),
          ),
          TextFormField(
            controller: idController,
            validator: (username) {
              if (username == null) {
                return null;
              }
              if (username.isEmpty) {
                return showSnackbar('Please Enter Your ID');
              }
            },
            keyboardType: TextInputType.name,
            style: textstyle.copyWith(
              color: primarycolor,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(horizontal: 15),
              border: InputBorder.none,
              disabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              hintText: 'Enter your username',
              hintStyle: textstyle.copyWith(
                color: greycolor,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }

  showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }
}
