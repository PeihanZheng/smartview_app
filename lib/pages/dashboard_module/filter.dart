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
  final filterCon = Get.put(FilterController());

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
                  const SizedBox(height: 5),
                  // Priority
                  priorityWiseFilter(),
                  const SizedBox(height: 15),
                  // Status
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
                  const SizedBox(height: 5),
                  Obx(
                    () => customChipWidget(
                      prioValue: filterCon.isAll.value,
                      onchanged: filterCon.onAllTasksSelected,
                      lable: allT,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Obx(
                    () => customChipWidget(
                      prioValue: filterCon.isIncomplete.value,
                      onchanged: filterCon.onIncompleteSelected,
                      lable: incompleteT,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Obx(
                    () => customChipWidget(
                      prioValue: filterCon.isComplete.value,
                      onchanged: filterCon.onCompleteSelected,
                      lable: completeT,
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Sort By
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
                  const SizedBox(height: 5),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      customChipWidget(
                        prioValue: isTime,
                        onchanged: (value) {
                          setState(() {
                            isTime = value!;
                          });
                        },
                        lable: timeT,
                      ),
                      const SizedBox(width: 10),
                      customChipWidget(
                        prioValue: !isTime,
                        onchanged: (value) {
                          setState(() {
                            isTime = !value!;
                          });
                        },
                        lable: priorityT,
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  // Reset & Apply Button
                  SizedBox(
                    width: Get.width,
                    child: Row(
                      children: [
                        Expanded(
                          child: resetButton(),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: applyButton(),
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

  Widget applyButton() {
    return ElevatedButton(
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
    );
  }

  Widget resetButton() {
    return ElevatedButton(
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
    );
  }

  Widget priorityWiseFilter() {
    return Obx(
      () => Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          customChipWidget(
            prioValue: filterCon.isHigh.value,
            onchanged: filterCon.onHighSelected,
            lable: highT,
          ),
          const SizedBox(width: 10),
          customChipWidget(
            prioValue: filterCon.isMedium.value,
            onchanged: filterCon.onMediumSelected,
            lable: mediumT,
          ),
          const SizedBox(width: 10),
          customChipWidget(
            prioValue: filterCon.isLow.value,
            onchanged: filterCon.onLowSelected,
            lable: lowT,
          ),
        ],
      ),
    );
  }

  Widget customChipWidget({bool? prioValue, Function(bool?)? onchanged, String? lable}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: whitecolor,
        boxShadow: [
          BoxShadow(
            offset: const Offset(1, 2),
            blurRadius: 2,
            spreadRadius: 1,
            color: textcolor.withOpacity(.15),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 20,
            height: 20,
            child: Transform.scale(
              scale: 1,
              child: Checkbox(
                value: prioValue,
                onChanged: onchanged,
                activeColor: primarycolor,
                checkColor: whitecolor,
              ),
            ),
          ),
          const SizedBox(width: 5),
          Text(
            lable!,
            style: textstyle.copyWith(
              fontWeight: FontWeight.normal,
              color: textcolor,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
