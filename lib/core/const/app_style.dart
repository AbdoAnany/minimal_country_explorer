import 'package:flutter/material.dart';

import 'app_color.dart';

class AppStyle {
  static TextStyle textGray10 = const TextStyle(color: Colors.grey, fontSize: 10);
  static TextStyle textOrange20 =
      const TextStyle(color: Colors.orange, fontSize: 20);
  static TextStyle textBlack18Bold = const TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );
  static TextStyle textBlack16 = const TextStyle(
      fontSize: 16, fontWeight: FontWeight.bold, color: AppColor.gray);
  static TextStyle textWhite12 = const TextStyle(
      fontSize: 12, fontWeight: FontWeight.bold, color: AppColor.gray);
}
