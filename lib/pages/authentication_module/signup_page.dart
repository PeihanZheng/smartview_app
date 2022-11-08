import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smarview_app/constants/themes/colors.dart';
import 'package:smarview_app/constants/themes/textstyles.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final idController = TextEditingController();
  final nameController = TextEditingController();
  final passwordController = TextEditingController();

  var isLoading = false;

  bool _obsecureText1 = true;
  bool _obsecureText2 = true;

  @override
  void dispose() {
    idController.dispose();
    nameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _toggle1() {
    setState(() {
      _obsecureText1 = !_obsecureText1;
    });
  }

  void _toggle2() {
    setState(() {
      _obsecureText2 = !_obsecureText2;
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
            height: Get.height * .15,
            color: primarycolor,
            child: Text(
              'Sign Up',
              style: textstyle.copyWith(
                fontSize: 35,
                color: whitecolor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: Get.width,
              height: Get.height * .85,
              decoration: const BoxDecoration(
                color: whitecolor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(80),
                ),
              ),
              padding: const EdgeInsets.only(top: 40, left: 30, right: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  inputWidget(
                    title: 'Firstname',
                    hintText: 'Enter your First Name',
                    validaterFunc: (firstname) {
                      if (firstname!.isEmpty) {
                        return showSnackbar('Please Enter Your First Name');
                      }
                    },
                    inputType: TextInputType.name,
                    action: TextInputAction.next,
                  ),
                  const SizedBox(height: 15),
                  inputWidget(
                    title: 'Lastname',
                    hintText: 'Enter your Last Name',
                    validaterFunc: (lastname) {
                      if (lastname!.isEmpty) {
                        return showSnackbar('Please Enter Your Last Name');
                      }
                    },
                    inputType: TextInputType.name,
                    action: TextInputAction.next,
                  ),
                  const SizedBox(height: 15),
                  inputWidget(
                    title: 'Email Address',
                    hintText: 'Enter your Email Address',
                    validaterFunc: (email) {
                      if (email == null) {
                        return null;
                      }
                      RegExp emailRegExp = RegExp(
                          r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");

                      if (email.isEmpty) {
                        return 'Email Address can\'t be empty';
                      } else if (!emailRegExp.hasMatch(email)) {
                        return showSnackbar('Enter a correct Email Address');
                      }
                    },
                    inputType: TextInputType.emailAddress,
                    action: TextInputAction.next,
                  ),
                  const SizedBox(height: 15),
                  inputWidget2(
                    title: 'Password',
                    hintText: 'Enter your Password',
                    validaterFunc: (password) {
                      if (password == null) {
                        return null;
                      }
                      if (password.isEmpty) {
                        return showSnackbar('Password can\'t be empty');
                      } else if (password.length < 6) {
                        return 'Enter a password with length at least 6';
                      }

                      return null;
                    },
                    inputType: TextInputType.text,
                    action: TextInputAction.next,
                    obsecureText: _obsecureText1,
                    toggleFunc: _toggle1,
                  ),
                  const SizedBox(height: 15),
                  inputWidget2(
                    title: 'Confirm Password',
                    hintText: 'Enter your Confirm Password',
                    validaterFunc: (conpassword) {
                      if (conpassword == null) {
                        return null;
                      }
                      if (conpassword.isEmpty) {
                        return showSnackbar('Confirm Password can\'t be empty');
                      } else if (conpassword.length < 6) {
                        return 'Enter a confirm password with length at least 6';
                      }

                      return null;
                    },
                    inputType: TextInputType.text,
                    action: TextInputAction.done,
                    obsecureText: _obsecureText2,
                    toggleFunc: _toggle2,
                  ),
                  const SizedBox(height: 30),
                  signupbutton(),
                  const Expanded(child: SizedBox()),
                  alreadyHaveAccountwidget(),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget alreadyHaveAccountwidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Already have an account?',
          style: textstyle.copyWith(
            fontSize: 14,
            color: textcolor,
            fontWeight: FontWeight.w700,
          ),
        ),
        TextButton(
          onPressed: () {
            Get.offNamed('/login');
          },
          child: Text(
            'Sign In',
            style: textstyle.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }

  Widget signupbutton() {
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
              'Sign Up',
              style: textstyle.copyWith(
                fontSize: 18,
                color: whitecolor,
                fontWeight: FontWeight.w500,
              ),
            ),
    );
  }

  Widget inputWidget2({
    TextEditingController? controller,
    String? title,
    String? Function(String?)? validaterFunc,
    String? hintText,
    TextInputAction? action,
    TextInputType? inputType,
    bool? obsecureText,
    Function? toggleFunc,
  }) {
    return Container(
      padding: const EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        color: whitecolor,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            blurRadius: 8,
            spreadRadius: 1,
            offset: const Offset(0, 3),
            color: primarycolor.withOpacity(.2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Text(
              title!,
              style: textstyle.copyWith(
                fontSize: 16,
                color: textcolor,
                fontWeight: FontWeight.w700,
                letterSpacing: 1,
              ),
            ),
          ),
          TextFormField(
            // controller: idController,
            validator: validaterFunc,
            keyboardType: inputType,
            textInputAction: action,
            obscureText: obsecureText!,
            style: textstyle.copyWith(
              color: primarycolor,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              border: InputBorder.none,
              disabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              hintText: hintText!,
              hintStyle: textstyle.copyWith(
                color: greycolor,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
              suffixIcon: GestureDetector(
                onTap: toggleFunc as void Function(),
                child: Icon(
                  obsecureText ? Icons.visibility_off : Icons.visibility,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget inputWidget(
      {TextEditingController? controller,
      String? title,
      String? Function(String?)? validaterFunc,
      String? hintText,
      TextInputAction? action,
      TextInputType? inputType}) {
    return Container(
      padding: const EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        color: whitecolor,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            blurRadius: 8,
            spreadRadius: 1,
            offset: const Offset(0, 3),
            color: primarycolor.withOpacity(.2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Text(
              title!,
              style: textstyle.copyWith(
                fontSize: 16,
                color: textcolor,
                fontWeight: FontWeight.w700,
                letterSpacing: 1,
              ),
            ),
          ),
          TextFormField(
            // controller: idController,
            validator: validaterFunc,
            textInputAction: action,
            keyboardType: inputType,
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
              hintText: hintText!,
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
