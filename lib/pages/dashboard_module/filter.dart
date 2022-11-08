import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/strings.dart';
import '../../constants/themes/colors.dart';
import '../../constants/themes/textstyles.dart';
import '../../controller/filter_controller.dart';

class FilterWidget extends StatefulWidget {
  const FilterWidget({Key? key}) : super(key: key);

  @override
  State<FilterWidget> createState() => _FilterWidgetState();
}

class _FilterWidgetState extends State<FilterWidget> {
  // final filterCon = Get.put(FilterController());

  bool isHigh = false;
  bool isMedium = false;
  bool isLow = false;

  bool isAll = false;
  bool isIncomplete = false;
  bool isComplete = false;

  bool isTime = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10, right: 5, left: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                filterByT,
                style: textstyle.copyWith(
                  fontWeight: FontWeight.bold,
                  color: textcolor,
                  fontSize: 22,
                  letterSpacing: .5,
                ),
              ),
              IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: const Icon(
                  Icons.close_rounded,
                  size: 30,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, right: 15),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Text(
                      priorityT,
                      style: textstyle.copyWith(
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                        color: textcolor,
                      ),
                    ),
                  ),
                  const SizedBox(height: 3),
                  priorityWiseFilter(),
                  const SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Text(
                      statusT,
                      style: textstyle.copyWith(
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                        color: textcolor,
                      ),
                    ),
                  ),
                  Chip(
                    backgroundColor: whitecolor,
                    padding: const EdgeInsets.only(top: 8, bottom: 8, left: 10, right: 5),
                    elevation: 2,
                    avatar: Transform.scale(
                      scale: 0.9,
                      child: Checkbox(
                        value: true,
                        onChanged: (value) {},
                        activeColor: primarycolor,
                        checkColor: whitecolor,
                      ),
                    ),
                    label: Text(
                      allT,
                      style: textstyle.copyWith(
                        fontWeight: FontWeight.normal,
                        color: textcolor,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Chip(
                    backgroundColor: whitecolor,
                    padding: const EdgeInsets.only(top: 8, bottom: 8, left: 10, right: 5),
                    elevation: 2,
                    avatar: Transform.scale(
                      scale: 0.9,
                      child: Checkbox(
                        value: false,
                        onChanged: (value) {},
                        activeColor: primarycolor,
                        checkColor: whitecolor,
                      ),
                    ),
                    label: Text(
                      incompleteT,
                      style: textstyle.copyWith(
                        fontWeight: FontWeight.normal,
                        color: textcolor,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Chip(
                    backgroundColor: whitecolor,
                    padding: const EdgeInsets.only(top: 8, bottom: 8, left: 10, right: 5),
                    elevation: 2,
                    avatar: Transform.scale(
                      scale: 0.9,
                      child: Checkbox(
                        value: false,
                        onChanged: (value) {},
                        activeColor: primarycolor,
                        checkColor: whitecolor,
                      ),
                    ),
                    label: Text(
                      completeT,
                      style: textstyle.copyWith(
                        fontWeight: FontWeight.normal,
                        color: textcolor,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Text(
                      sortByT,
                      style: textstyle.copyWith(
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                        color: textcolor,
                      ),
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Chip(
                        backgroundColor: whitecolor,
                        padding: const EdgeInsets.only(top: 8, bottom: 8, left: 10, right: 5),
                        elevation: 2,
                        avatar: Transform.scale(
                          scale: 0.9,
                          child: Checkbox(
                            value: false,
                            onChanged: (value) {},
                            activeColor: primarycolor,
                            checkColor: whitecolor,
                          ),
                        ),
                        label: Text(
                          timeT,
                          style: textstyle.copyWith(
                            fontWeight: FontWeight.normal,
                            color: textcolor,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Chip(
                        backgroundColor: whitecolor,
                        padding: const EdgeInsets.only(top: 8, bottom: 8, left: 10, right: 5),
                        elevation: 2,
                        avatar: Transform.scale(
                          scale: 0.9,
                          child: Checkbox(
                            value: false,
                            onChanged: (value) {},
                            activeColor: primarycolor,
                            checkColor: whitecolor,
                          ),
                        ),
                        label: Text(
                          priorityT,
                          style: textstyle.copyWith(
                            fontWeight: FontWeight.normal,
                            color: textcolor,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: Get.width,
                    child: Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(50))),
                              backgroundColor: MaterialStateProperty.all(primarycolor),
                              fixedSize: MaterialStateProperty.all(const Size.fromHeight(45)),
                            ),
                            child: Text(
                              resetT,
                              style: textstyle.copyWith(
                                fontSize: 16,
                                color: whitecolor,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(50))),
                              backgroundColor: MaterialStateProperty.all(primarycolor),
                              fixedSize: MaterialStateProperty.all(const Size.fromHeight(45)),
                            ),
                            child: Text(
                              applyT,
                              style: textstyle.copyWith(
                                fontSize: 16,
                                color: whitecolor,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget priorityWiseFilter() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Chip(
          backgroundColor: whitecolor,
          padding: const EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 5),
          elevation: 5,
          avatar: Transform.scale(
            scale: 0.9,
            child: Checkbox(
              value: isHigh,
              onChanged: (value) {
                setState(() {
                  isHigh = value!;
                });
              },
              activeColor: redcolor,
              checkColor: textcolor,
            ),
          ),
          label: Text(
            highT,
            style: textstyle.copyWith(
              fontWeight: FontWeight.normal,
              color: textcolor,
              fontSize: 14,
            ),
          ),
        ),
        const SizedBox(width: 10),
        Chip(
          backgroundColor: whitecolor,
          padding: const EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 5),
          elevation: 5,
          avatar: Transform.scale(
            scale: 0.9,
            child: Checkbox(
              value: true,
              onChanged: (value) {},
              activeColor: yellowcolor,
              checkColor: textcolor,
            ),
          ),
          label: Text(
            mediumT,
            style: textstyle.copyWith(
              fontWeight: FontWeight.normal,
              color: textcolor,
              fontSize: 14,
            ),
          ),
        ),
        const SizedBox(width: 10),
        Chip(
          backgroundColor: whitecolor,
          padding: const EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 5),
          elevation: 5,
          avatar: Transform.scale(
            scale: 0.9,
            child: Checkbox(
              value: true,
              onChanged: (value) {},
              activeColor: greencolor,
              checkColor: textcolor,
            ),
          ),
          label: Text(
            lowT,
            style: textstyle.copyWith(
              fontWeight: FontWeight.normal,
              color: textcolor,
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }
}
