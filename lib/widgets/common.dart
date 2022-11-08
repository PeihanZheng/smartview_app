import 'package:flutter/material.dart';

import '../constants/assets.dart';
import '../constants/strings.dart';
import '../constants/themes/colors.dart';
import '../constants/themes/textstyles.dart';

Widget appbatTitleText() {
  return Text(
    smartViewT,
    style: textstyle.copyWith(
      fontSize: 20,
      fontWeight: FontWeight.w700,
      letterSpacing: .5,
      color: whitecolor,
    ),
  );
}

Widget sidemenuButton({Function? onPressed}) {
  return IconButton(
    onPressed: onPressed as void Function(),
    icon: Image.asset(
      menuIcon,
      width: 25,
      color: whitecolor,
    ),
  );
}
