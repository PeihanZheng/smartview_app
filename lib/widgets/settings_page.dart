import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smarview_app/constants/strings.dart';
import 'package:smarview_app/constants/themes/textstyles.dart';
import 'package:smarview_app/widgets/common.dart';
import 'package:smarview_app/widgets/custom_drawer.dart';

import '../constants/assets.dart';
import '../constants/themes/colors.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int? selectValue;
  bool isTurnOn = false;

  List<int> timeList = [
    1,
    5,
    10,
    15,
    30,
    60,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      drawer: const MyDrawer(isFromDashboard: false),
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 60,
        backgroundColor: primarycolor,
        title: appbatTitleText(),
        leading: sidemenuButton(onPressed: () {
          _scaffoldKey.currentState?.openDrawer();
        }),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: IconButton(
              onPressed: () {
                Get.offNamed('/home-page');
              },
              icon: Image.asset(
                homeIcon,
                width: 25,
                color: whitecolor,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 15, left: 10, right: 10, bottom: 20),
        child: Column(
          children: [
            notificationsCard(),
            const SizedBox(height: 15),
            timeIntervalCard(),
            const Expanded(child: SizedBox()),
            ElevatedButton(
              onPressed: () {},
              style: ButtonStyle(
                padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: Get.width * .2, vertical: 10)),
                backgroundColor: MaterialStateProperty.all(primarycolor),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(50))),
              ),
              child: Text(
                applyT,
                style: textstyle.copyWith(
                  fontSize: 18,
                  color: whitecolor,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget timeIntervalCard() {
    return ListTile(
      tileColor: primarycolor,
      visualDensity: VisualDensity.standard,
      contentPadding: const EdgeInsets.only(left: 20, top: 10, bottom: 10, right: 15),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      title: Text(
        timeIntT,
        style: textstyle.copyWith(
          fontSize: 18,
          color: whitecolor,
          letterSpacing: 1,
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 3),
        child: Text(
          timeIntSubT,
          style: textstyle.copyWith(
            fontSize: 16,
            color: whitecolor.withOpacity(.6),
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
      trailing: Container(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        decoration: BoxDecoration(
          color: whitecolor.withOpacity(.60),
          borderRadius: BorderRadius.circular(8),
        ),
        child: DropdownButton<int>(
          borderRadius: BorderRadius.circular(8),
          isExpanded: false,
          items: timeList.map((e) {
            return DropdownMenuItem(
              alignment: AlignmentDirectional.center,
              value: e,
              child: Text(
                '$e',
                style: textstyle.copyWith(
                  fontSize: 16,
                  color: textcolor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            );
          }).toList(),
          value: selectValue,
          onChanged: (val) {
            setState(() {
              selectValue = val;
            });
          },
          hint: Text(
            'Select',
            style: textstyle.copyWith(
              fontSize: 14,
              color: whitecolor,
            ),
          ),
          style: textstyle.copyWith(
            fontSize: 14,
            color: whitecolor,
            fontWeight: FontWeight.w700,
          ),
          underline: const SizedBox(),
          isDense: true,
        ),
      ),
    );
  }

  Widget notificationsCard() {
    return ListTile(
      tileColor: primarycolor,
      visualDensity: VisualDensity.standard,
      contentPadding: const EdgeInsets.only(left: 20, top: 10, bottom: 10, right: 5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      title: Text(
        ntfcnsT,
        style: textstyle.copyWith(
          fontSize: 18,
          color: whitecolor,
          letterSpacing: 1,
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 3),
        child: Text(
          ntfcnsSubT,
          style: textstyle.copyWith(
            fontSize: 16,
            color: whitecolor.withOpacity(.6),
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
      trailing: Switch(
        value: isTurnOn,
        activeColor: whitecolor.withOpacity(.9),
        onChanged: (value) {
          setState(() {
            isTurnOn = value;
          });
        },
      ),
    );
  }
}
