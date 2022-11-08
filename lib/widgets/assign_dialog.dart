import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smarview_app/constants/strings.dart';
import 'package:smarview_app/constants/themes/colors.dart';
import 'package:smarview_app/constants/themes/textstyles.dart';

class AssignDialog extends StatefulWidget {
  const AssignDialog({Key? key}) : super(key: key);

  @override
  State<AssignDialog> createState() => _AssignDialogState();
}

class _AssignDialogState extends State<AssignDialog> {
  String? selectValue;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      clipBehavior: Clip.hardEdge,
      insetPadding: const EdgeInsets.symmetric(horizontal: 30),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      backgroundColor: primarycolor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  SizedBox(
                    width: Get.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Camera Name',
                          style: textstyle.copyWith(
                            fontSize: 21,
                            color: whitecolor,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Container(
                          transform: Matrix4.translationValues(15, -15, 0),
                          alignment: Alignment.centerRight,
                          child: IconButton(
                            onPressed: () {
                              Get.back();
                            },
                            icon: Icon(
                              Icons.close_rounded,
                              size: 30,
                              color: whitecolor.withOpacity(.9),
                            ),
                            splashRadius: 25,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 5),
                  SizedBox(
                    width: Get.width,
                    child: Row(
                      children: [
                        Expanded(
                          child: Wrap(
                            alignment: WrapAlignment.start,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              Icon(
                                Icons.calendar_month,
                                color: whitecolor.withOpacity(.9),
                              ),
                              const SizedBox(width: 5),
                              Text(
                                '10/07/2020',
                                style: textstyle.copyWith(
                                  fontSize: 14,
                                  color: whitecolor.withOpacity(.9),
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Wrap(
                            alignment: WrapAlignment.start,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              Icon(
                                Icons.timer_sharp,
                                color: whitecolor.withOpacity(.9),
                              ),
                              const SizedBox(width: 5),
                              Text(
                                '02:36',
                                style: textstyle.copyWith(
                                  fontSize: 14,
                                  color: whitecolor.withOpacity(.9),
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    'Two graffitis detected at 02:36:14',
                    style: textstyle.copyWith(
                      fontSize: 15,
                      color: whitecolor.withOpacity(.8),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Agent',
                        style: textstyle.copyWith(
                          fontSize: 14,
                          color: whitecolor,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(width: 20),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                        decoration: BoxDecoration(
                          color: whitecolor.withOpacity(.60),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: DropdownButton<String>(
                          borderRadius: BorderRadius.circular(8),
                          isExpanded: false,
                          items: agentList.map((e) {
                            return DropdownMenuItem(
                              alignment: AlignmentDirectional.centerStart,
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
                              color: textcolor,
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
                    ],
                  ),
                  const SizedBox(height: 20),
                  Container(
                    width: Get.width,
                    decoration: BoxDecoration(
                      color: whitecolor.withOpacity(.24),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: TextFormField(
                      // controller: controller,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        hintText: 'Write Additional Notes Here',
                        hintStyle: textstyle.copyWith(
                          fontSize: 15,
                          color: whitecolor.withOpacity(.6),
                        ),
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                      ),
                      maxLines: 4,
                      cursorColor: Colors.black,
                      style: textstyle.copyWith(
                        fontSize: 15,
                        color: whitecolor,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(whitecolor),
                        padding: MaterialStateProperty.all(EdgeInsets.zero),
                        fixedSize: MaterialStateProperty.all(const Size(100, 40)),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(50))),
                      ),
                      onPressed: () {
                        Get.back();
                      },
                      child: Text(
                        assignT,
                        style: textstyle.copyWith(
                          color: primarycolor,
                          fontWeight: FontWeight.bold,
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
    );
  }

  List<String> agentList = [
    "Joe",
    "Bob",
    "Robert",
  ];
}
