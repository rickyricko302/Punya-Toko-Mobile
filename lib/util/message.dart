import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:punyatoko/data/constants/assets_color.dart';
import 'package:punyatoko/data/constants/assets_key.dart';
import 'package:punyatoko/presentation/widgets/texts/poppins_text.dart';

class Message {
  static showSuccessToast({required String msg}) {
    FToast fToast = FToast();
    fToast.init(AssetsKey.navigatorKey.currentContext!);
    fToast.showToast(
        child: Container(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 15),
      decoration: BoxDecoration(
          color: AssetsColor.youngGreen,
          borderRadius: BorderRadius.circular(50)),
      child: PoppinsText(
        text: msg,
        fontSize: 15.sp,
        color: Colors.white,
      ),
    ));
  }

  static showErrorToast({required String msg}) {
    FToast fToast = FToast();
    fToast.init(AssetsKey.navigatorKey.currentContext!);
    fToast.showToast(
        child: Container(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
      decoration: BoxDecoration(
          color: AssetsColor.red, borderRadius: BorderRadius.circular(50)),
      child: PoppinsText(
        text: msg,
        fontSize: 15,
        color: Colors.white,
      ),
    ));
  }
}
