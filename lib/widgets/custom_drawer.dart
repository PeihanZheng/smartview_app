import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smarview_app/constants/assets.dart';
import 'package:smarview_app/constants/strings.dart';
import 'package:smarview_app/constants/themes/colors.dart';
import 'package:smarview_app/constants/themes/textstyles.dart';
import 'package:smarview_app/pages/dashboard_module/home_page.dart';
import 'package:smarview_app/pages/authentication_module/login_page.dart';
import 'package:smarview_app/widgets/settings_page.dart';

class MyDrawer extends StatelessWidget {
  final bool isFromDashboard;
  const MyDrawer({Key? key, required this.isFromDashboard}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: primarycolor,
      child: ListView(
        physics: const NeverScrollableScrollPhysics(),
        // Important: Remove any padding from the ListView.
        padding: const EdgeInsets.only(top: 60),
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 35,
                backgroundColor: Colors.white,
                child: Text(
                  "R",
                  style: TextStyle(fontSize: 40.0),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Rocco Morrio',
                style: textstyle.copyWith(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Divider(
            thickness: 1,
            color: whitecolor.withOpacity(.7),
            indent: 10,
            endIndent: 10,
          ),
          const SizedBox(height: 10),
          ListTile(
            leading: Image.asset(
              homeIcon,
              color: whitecolor,
              width: 25,
              height: 25,
            ),
            title: Text(
              homeT,
              style: textstyle.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: whitecolor,
              ),
            ),
            horizontalTitleGap: 0,
            onTap: isFromDashboard
                ? () {
                    Get.back();
                    Get.toNamed('/home-page');
                  }
                : () {
                    Get.offNamed('/home-page');
                  },
          ),
          ListTile(
            horizontalTitleGap: 0,
            leading: Image.asset(
              galleryIcon,
              color: whitecolor,
              width: 25,
              height: 25,
            ),
            title: Text(
              galleryT,
              style: textstyle.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: whitecolor,
              ),
            ),
            onTap: () {
              Get.back();
            },
          ),
          ListTile(
            horizontalTitleGap: 0,
            leading: Image.asset(
              slideSIcon,
              color: whitecolor,
              width: 25,
              height: 25,
            ),
            title: Text(
              slideshowT,
              style: textstyle.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: whitecolor,
              ),
            ),
            onTap: () {
              Get.back();
            },
          ),
          ListTile(
            horizontalTitleGap: 0,
            leading: Image.asset(
              settingsIcon,
              color: whitecolor,
              width: 25,
              height: 25,
            ),
            title: Text(
              settingsT,
              style: textstyle.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: whitecolor,
              ),
            ),
            onTap: isFromDashboard
                ? () {
                    Get.back();
                    Get.toNamed('/settings-page');
                  }
                : () {
                    Get.offNamed('/settings-page');
                  },
          ),
          const SizedBox(height: 10),
          Divider(
            thickness: 1,
            color: whitecolor.withOpacity(.7),
            indent: 10,
            endIndent: 10,
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 20, top: 0),
            child: Text(
              communicateT,
              style: textstyle.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: whitecolor.withOpacity(.7),
                letterSpacing: 1,
              ),
            ),
          ),
          const SizedBox(height: 5),
          ListTile(
            horizontalTitleGap: 0,
            leading: Image.asset(
              logoutIcon,
              color: whitecolor,
              width: 25,
              height: 25,
            ),
            title: Text(
              logoutT,
              style: textstyle.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: whitecolor,
              ),
            ),
            onTap: () {
              Get.off(const Loginpage());
            },
          ),
        ],
      ),
    );
  }
}
