import 'dart:ui';

import 'package:flutter/material.dart';

class AppColor {
  static const Color themeColor = Colors.indigoAccent;
}

TextStyle header1(textColors) {
  return TextStyle(
    fontSize: 28,
    color: textColors,
    fontWeight: FontWeight.w700,
  );
}

TextStyle header4(textColors) {
  return TextStyle(
    fontSize: 16,
    color: textColors,
    fontWeight: FontWeight.w400,
  );
}
//