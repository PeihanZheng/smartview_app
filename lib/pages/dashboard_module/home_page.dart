import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smarview_app/constants/strings.dart';
import 'package:smarview_app/constants/themes/textstyles.dart';
import 'package:smarview_app/models/analytics_models/fr.dart';
import 'package:smarview_app/models/analytics_models/loitering.dart';
import 'package:smarview_app/models/data_models/user_model.dart';
import 'package:smarview_app/pages/dashboard_module/filter.dart';
import 'package:smarview_app/services/analytics_service.dart';
import 'package:smarview_app/widgets/assign_dialog.dart';
import 'package:smarview_app/widgets/custom_drawer.dart';

import '../../constants/assets.dart';
import '../../constants/themes/colors.dart';
import '../../widgets/common.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Timer? t;

  bool isLoading = false;
  UserModel userData = UserModel();
  LoiteringModel? loiteringModel = LoiteringModel();
  FRModel? frModel = FRModel();

  void getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final decodedUser = UserModel.fromJson(json.decode(prefs.getString('userdata').toString()));
    setState(() {
      userData = decodedUser;
    });
    print(userData.accessToken);
  }

  void getResults() {
    print('get results........');

    t = Timer.periodic(
      const Duration(seconds: 15),
      (_) {
        print('......... results........');
        getLoiteringResults();
        getFrResults();
      },
    );
  }

  getLoiteringResults() async {
    loiteringModel = await Analytics().loiteringResults(
      context,
      accessToken: userData.accessToken,
      camId: "cam_id",
      start: "2020-10-01T03:00:00.000Z",
      end: "2020-11-01T02:59:59.000Z",
      id: "fa9e5b11-0998-472d-aad0-67c5bf0e6d27",
    );
    print('-------------$loiteringModel--------------');
    setState(() {});
  }

  getFrResults() async {
    frModel = await Analytics().FRResults(
      context,
      accessToken: userData.accessToken,
      start: "2020-10-01T03:00:00.000Z",
      end: "2020-11-01T02:59:59.000Z",
      id: "fa9e5b11-0998-472d-aad0-67c5bf0e6d27",
    );
    print('-------------$frModel--------------');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      drawer: const MyDrawer(isFromDashboard: true),
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 60,
        backgroundColor: primarycolor,
        title: appbatTitleText(),
        leading: sidemenuButton(onPressed: () {
          _scaffoldKey.currentState?.openDrawer();
        }),
        actions: [
          mapButton(),
          searchButton(),
        ],
      ),
      floatingActionButton: scrollUpButton(),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            alertCountings(),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Text(
                recentT,
                style: textstyle.copyWith(
                  fontWeight: FontWeight.w700,
                  letterSpacing: .5,
                  color: textcolor,
                ),
              ),
            ),
            const SizedBox(height: 5),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              itemCount: dataList.length,
              itemBuilder: (context, index) {
                return alertsCard(
                  type: dataList[index]['type'],
                  camName: dataList[index]['camera_name'],
                  agent: dataList[index]['agent'],
                  time: dataList[index]['time'],
                  incident: dataList[index]['event'],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget mapButton() {
    return IconButton(
      onPressed: () {
        Get.offNamed('/map-page');
      },
      icon: Image.asset(
        mapIcon,
        width: 25,
        color: whitecolor,
      ),
    );
  }

  Widget searchButton() {
    return IconButton(
      onPressed: () {},
      icon: const Icon(
        Icons.search,
        size: 25,
      ),
    );
  }

  Widget scrollUpButton() {
    return SizedBox(
      width: 45,
      height: 45,
      child: FittedBox(
        child: FloatingActionButton(
          elevation: 5,
          backgroundColor: primarycolor,
          onPressed: () {
            _scrollController.animateTo(
              0.0,
              duration: const Duration(milliseconds: 100),
              curve: Curves.easeInOut,
            );
          },
          child: const Icon(
            Icons.keyboard_arrow_up_rounded,
            size: 35,
          ),
        ),
      ),
    );
  }

  void openBottomsheet() {
    Get.bottomSheet(
      const FilterWidget(),
      backgroundColor: whitecolor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
    );
    return;
  }

  Widget alertCountings() {
    return SizedBox(
      width: Get.width,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                alertTypeChipWidget(type: highT, count: 2, color: redcolor),
                const SizedBox(width: 10),
                alertTypeChipWidget(type: mediumT, count: 2, color: yellowcolor),
                const SizedBox(width: 10),
                alertTypeChipWidget(type: lowT, count: 1, color: greencolor),
              ],
            ),
            IconButton(
              onPressed: () {
                openBottomsheet();
              },
              icon: Image.asset(
                filterIcon,
                width: 25,
              ),
              splashRadius: 25,
            ),
          ],
        ),
      ),
    );
  }

  Widget alertTypeChipWidget({String? type, int? count, Color? color}) {
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 5, top: 5, bottom: 5),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(50),
      ),
      child: Row(
        children: [
          Text(
            type!,
            style: textstyle.copyWith(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: textcolor,
            ),
          ),
          const SizedBox(width: 5),
          CircleAvatar(
            radius: 12,
            backgroundColor: whitecolor,
            child: Text(
              (count ?? 0).toString(),
              style: textstyle.copyWith(
                fontSize: 14,
                color: textcolor,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget alertsCard({String? type, String? camName, String? agent, String? time, String? incident}) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      color: whitecolor,
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.only(left: 10, top: 10),
            width: Get.width,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: SizedBox(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 10,
                              backgroundColor: type == highT
                                  ? redcolor
                                  : type == mediumT
                                      ? yellowcolor
                                      : greencolor,
                            ),
                            const SizedBox(width: 10),
                            Text(
                              camName!,
                              style: textstyle.copyWith(
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Padding(
                          padding: const EdgeInsets.only(left: 30),
                          child: Text(
                            '$agent $time',
                            style: textstyle.copyWith(
                              fontWeight: FontWeight.w600,
                              fontSize: 13,
                              color: textcolor,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 30),
                          child: Text(
                            incident!,
                            style: textstyle.copyWith(
                              fontWeight: FontWeight.normal,
                              fontSize: 13,
                              color: greycolor,
                            ),
                          ),
                        ),
                        const SizedBox(height: 2),
                        Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: Row(
                            children: [
                              IconButton(
                                splashRadius: 20,
                                onPressed: () {},
                                icon: Image.asset(
                                  cameraIcon,
                                  width: 20,
                                  color: primarycolor,
                                ),
                              ),
                              IconButton(
                                splashRadius: 20,
                                onPressed: () {},
                                icon: Image.asset(
                                  playIcon,
                                  width: 20,
                                  color: primarycolor,
                                ),
                              ),
                              IconButton(
                                splashRadius: 20,
                                onPressed: () {},
                                icon: Image.asset(
                                  imageIcon,
                                  width: 20,
                                  color: primarycolor,
                                ),
                              ),
                              const Expanded(child: SizedBox()),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                PopupMenuButton(
                  padding: EdgeInsets.zero,
                  splashRadius: 25,
                  icon: const Icon(
                    Icons.more_vert,
                  ),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      child: ListTile(
                        dense: true,
                        title: Text(
                          escalateT,
                          style: textstyle.copyWith(fontSize: 16, color: textcolor),
                        ),
                        visualDensity: VisualDensity.compact,
                      ),
                    ),
                    PopupMenuItem(
                      child: ListTile(
                        dense: true,
                        title: Text(
                          falseAlarmT,
                          style: textstyle.copyWith(fontSize: 16, color: textcolor),
                        ),
                        visualDensity: VisualDensity.compact,
                      ),
                    ),
                    PopupMenuItem(
                      child: ListTile(
                        dense: true,
                        title: Text(
                          navigateT,
                          style: textstyle.copyWith(fontSize: 16, color: textcolor),
                        ),
                        visualDensity: VisualDensity.compact,
                      ),
                    ),
                    PopupMenuItem(
                      child: ListTile(
                        dense: true,
                        title: Text(
                          resolveT,
                          style: textstyle.copyWith(fontSize: 16, color: textcolor),
                        ),
                        visualDensity: VisualDensity.compact,
                      ),
                    ),
                    PopupMenuItem(
                      child: ListTile(
                        dense: true,
                        title: Text(
                          closeT,
                          style: textstyle.copyWith(fontSize: 16, color: textcolor),
                        ),
                        visualDensity: VisualDensity.compact,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            right: 0,
            bottom: 0,
            child: InkWell(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return const AssignDialog();
                    });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                decoration: const BoxDecoration(
                  color: primarycolor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15),
                  ),
                ),
                child: Text(
                  assignT,
                  style: textstyle.copyWith(fontSize: 16, color: whitecolor),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Map<String, dynamic>> dataList = [
    {
      "type": "High",
      "camera_name": "Toll Booth -3 T2",
      "agent": "Bob",
      "time": "04:31",
      "event": "Fighting detected at 04:31:00",
    },
    {
      "type": "High",
      "camera_name": "2nd Avenue",
      "agent": "Dennis",
      "time": "02:36",
      "event": "2 graffitis detected at 02:36:14",
    },
    {
      "type": "Medium",
      "camera_name": "Entrance 3",
      "agent": "Richi",
      "time": "06:36",
      "event": "unauthorized entry detected at 06:36:14, Person is male East Asian Young adult wearing a jacket",
    },
    {
      "type": "Medium",
      "camera_name": "19th Main  Road Corner",
      "agent": "John",
      "time": "12:39",
      "event": "Congestion detected at 12:29:18. The number of vehicles exceeded 15",
    },
    {
      "type": "Low",
      "camera_name": "4th Street",
      "agent": "Mark",
      "time": "03:36",
      "event": "10 people have been detected since 03:36:14",
    },
  ];
}
